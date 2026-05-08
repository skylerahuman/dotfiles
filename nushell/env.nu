# Installed by:
# version = "0.112.2"
#
# ==============================================================================
# Phase 1: Environment Variables & Paths (Global Scope)
# ==============================================================================

$env.XDG_CONFIG_HOME = $"($env.USERPROFILE)/AppData/Config"
$env.XDG_CACHE_HOME = $"($env.LOCALAPPDATA)/cache"

# DECLARE YOUR ACTIVE THEME HERE (Matches the filename in your themes folder)
$env.STARSHIP_THEME = "rose-pine-moon"

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
    starship init nu | save -f $starship_init_script
}
