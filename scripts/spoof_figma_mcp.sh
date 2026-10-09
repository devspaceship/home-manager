#!/usr/bin/env bash
set -euo pipefail

# https://github.com/anomalyco/opencode/issues/988#issuecomment-4022520800
oauth_dir="$HOME/.local/share/opencode/figma-oauth"
auth_file="$HOME/.local/share/opencode/mcp-auth.json"

umask 077
registration=$(curl -fsS 'https://api.figma.com/v1/oauth/mcp/register' \
	--header 'Content-Type: application/json' \
	--data '{
    "client_name": "Claude Code (figma)",
    "redirect_uris": ["http://127.0.0.1:19876/mcp/oauth/callback"],
    "grant_types": ["authorization_code", "refresh_token"],
    "response_types": ["code"],
    "token_endpoint_auth_method": "none"
  }')

mkdir -p "$oauth_dir"
jq -ejr '.client_id' <<<"$registration" >"$oauth_dir/client-id.txt"
jq -ejr '.client_secret' <<<"$registration" >"$oauth_dir/client-secret.txt"

if [[ -f "$auth_file" ]]; then
	auth=$(jq 'del(.figma)' "$auth_file")
	printf '%s\n' "$auth" >"$auth_file"
fi

opencode mcp auth figma
