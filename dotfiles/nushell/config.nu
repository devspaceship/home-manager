# ── Completions (carapace) ────────────────────────────────────────────────────
# Replaces OMZ plugins: aws, docker, docker-compose, gh, git, terraform, etc.
# Regenerate: rm ~/.cache/carapace/init.nu && restart
source ~/.cache/carapace/init.nu

# ── Prompt (starship) ─────────────────────────────────────────────────────────
# Regenerate: rm ~/.cache/starship/init.nu && restart
use ~/.cache/starship/init.nu

# ── Node version manager (fnm) ────────────────────────────────────────────────
# Replaces NVM (bash-only). Regenerate: rm ~/.cache/fnm/init.nu && restart
source ~/.cache/fnm/init.nu

# ── Shell config ──────────────────────────────────────────────────────────────
$env.config.edit_mode = "vi"                    # bindkey -v
$env.config.show_banner = false
$env.config.history.max_size = 100_000
$env.config.history.file_format = "sqlite"
$env.config.completions.case_sensitive = false
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"

# ── Aliases ───────────────────────────────────────────────────────────────────

## Docker Compose
alias dc = docker compose
alias dcu = docker compose up
alias dcud = docker compose up -d
alias dcd = docker compose down
alias dcdv = docker compose down -v
alias dcl = docker compose logs
alias dclf = docker compose logs -f
alias dce = docker compose exec
alias dcr = docker compose run

## Lazygit
alias lg = lazygit

## Nvim
alias v = nvim
alias vi = nvim
alias vim = nvim

## OpenCode
alias oc = opencode

## Pnpm
alias p = pnpm
alias pi = pnpm install
alias px = pnpx

## Terraform
alias tf = terraform
alias tfi = terraform init
alias tfp = terraform plan
alias tfa = terraform apply

## Tmux
alias t = tmux
alias ta = tmux attach
