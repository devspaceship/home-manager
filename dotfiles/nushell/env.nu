# ── Environment ──────────────────────────────────────────────────────────────
$env.LANG = "en_US.UTF-8"
$env.EDITOR = "nvim"
$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.GPG_TTY = (^tty | str trim)

$env.PNPM_HOME = $"($env.HOME)/.local/share/pnpm"

$env.OPENCODE_EXPERIMENTAL_LSP_TOOL = "true"
$env.OPENCODE_ENABLE_EXA = "true"

# ── PATH ─────────────────────────────────────────────────────────────────────
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend [
        $"($env.HOME)/bin"
        $"($env.HOME)/.local/bin"
        $"($env.HOME)/.nix-profile/bin"
        $"($env.HOME)/.cargo/bin"
        $env.PNPM_HOME
    ]
    | append [
        $"($env.HOME)/go/bin"
        $"($env.HOME)/.local/share/nvim/mason/bin"
    ]
    | uniq
    | where { |p| $p | path exists }
)

# ── Cache generation ──────────────────────────────────────────────────────────
# Each tool generates a .nu init file on first run.
# To force regeneration, delete the cache file and restart the shell.
# Note: env.nu runs before config.nu is parsed, so these files will exist
# by the time config.nu tries to source them — even on first run.

let cache = $"($env.HOME)/.cache"

let starship_init = $"($cache)/starship/init.nu"
if not ($starship_init | path exists) {
    mkdir ($starship_init | path dirname)
    starship init nu | save -f $starship_init
}

let carapace_init = $"($cache)/carapace/init.nu"
if not ($carapace_init | path exists) {
    mkdir ($carapace_init | path dirname)
    carapace _carapace nushell | save -f $carapace_init
}

let fnm_init = $"($cache)/fnm/init.nu"
if not ($fnm_init | path exists) {
    mkdir ($fnm_init | path dirname)
    fnm env --shell nushell | save -f $fnm_init
}

# ── .env loading ──────────────────────────────────────────────────────────────
# Equivalent to zprofile's: set -a; source .env; set +a
def --env load-dotenv [file: string] {
    if ($file | path exists) {
        open --raw $file
        | lines
        | where { |l|
            not ($l | str starts-with "#") and ($l | str trim | is-not-empty)
        }
        | parse --regex "^(?P<key>[^=]+)=(?P<value>.*)$"
        | each { |row| { ($row.key | str trim): ($row.value | str trim) } }
        | reduce --fold {} { |it, acc| $acc | merge $it }
        | load-env
    }
}

load-dotenv $"($env.HOME)/.config/home-manager/.env"
load-dotenv $"($env.HOME)/.env"

if $nu.os-info.name == "macos" {
    $env.CC = "/usr/bin/clang"
    $env.CXX = "/usr/bin/clang++"
}
