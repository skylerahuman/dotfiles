# Installed by:
# version = "0.112.2"
#
# ==============================================================================
# Phase 1: Environment Variables & Paths (Global Scope)
# ==============================================================================

$env.XDG_CONFIG_HOME = $"($env.USERPROFILE)/AppData/Config"
$env.XDG_CACHE_HOME = $"($env.USERPROFILE)/AppData/Local/Cache"
$env.XDG_DATA_HOME = $"($env.USERPROFILE)/AppData/Local/Share"
$env.XDG_STATE_HOME = $"($env.USERPROFILE)/AppData/Local/State"

# App-specific environment overrides
$env.SCOOP = $"($env.USERPROFILE)/scoop"
$env.SCOOP_GLOBAL = "C:/ProgramData/Scoop"
$env.CARGO_HOME = $"($env.XDG_DATA_HOME)/cargo"
$env.RUSTUP_HOME = $"($env.XDG_DATA_HOME)/rustup"

# Node Pi is intentionally isolated under XDG_DATA_HOME rather than system Node.
$env.PI_NODE_HOME = $"($env.XDG_DATA_HOME)/pi-node/current"
$env.PI_NODE_BIN = $env.PI_NODE_HOME
$env.PATH = (
    $env.PATH
    | prepend $env.PI_NODE_BIN
    | uniq
)

# DECLARE YOUR ACTIVE THEME HERE (Matches the filename in your themes folder)
$env.STARSHIP_THEME = "rose-pine-moon"
$env.STARSHIP_CACHE = $env.XDG_CACHE_HOME

# ==============================================================================
# Phase 2: Just-In-Time (JIT) Starship Compilation
# ==============================================================================

# Define the source files
let starship_base = $"($env.XDG_CONFIG_HOME)/starship/base.toml"
let starship_theme_file = $"($env.XDG_CONFIG_HOME)/starship/themes/($env.STARSHIP_THEME).toml"

# Define the ephemeral cache targets
let starship_cache_dir = $"($env.XDG_CACHE_HOME)/starship"
let compiled_starship_config = $"($starship_cache_dir)/compiled_($env.STARSHIP_THEME).toml"
let starship_init_script = $"($starship_cache_dir)/init.nu"

# Point the Starship binary to the dynamically compiled cache
$env.STARSHIP_CONFIG = $compiled_starship_config

# 1. Compile the unified TOML if the current theme hasn't been built yet
if not ($compiled_starship_config | path exists) {
    mkdir $starship_cache_dir
    let base_record = (open $starship_base)
    let theme_record = (open $starship_theme_file)

    # Deep merge and serialize directly to the local cache
    ($base_record | merge $theme_record) | save -f $compiled_starship_config
}

# 2. Generate the Nushell prompt hooks if missing
if not ($starship_init_script | path exists) {
    mkdir $starship_cache_dir
    let starship_binary = (which starship | get path.0)
    ^$starship_binary init nu | save -f $starship_init_script
}
$env.STARSHIP_INIT_SCRIPT = $starship_init_script

# ==============================================================================
# Phase 3: Atuin configuration
# ==============================================================================

# Define Atuin Boundaries: Config in vault, Data/Logs in Local storage
$env.ATUIN_CONFIG_DIR = $"($env.XDG_CONFIG_HOME)/atuin"
$env.ATUIN_DATA_DIR   = $"($env.LOCALAPPDATA)/atuin"
$env.ATUIN_LOG_DIR    = $"($env.LOCALAPPDATA)/atuin/log"

# Self-Healing Init Script Caching
let atuin_cache = $"($env.XDG_CACHE_HOME)/atuin"
let atuin_script = $"($atuin_cache)/atuin_init.nu"

if not ($atuin_script | path exists) {
    mkdir $atuin_cache
    # Mechanical "Why": This generates the keybindings once so startup stays <10ms
    atuin init nu | save --force $atuin_script
}
$env.ATUIN_INIT_SCRIPT = $atuin_script
