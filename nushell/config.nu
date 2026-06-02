# config.nu
#
# Installed by:
# version = "0.112.2"

# Starship Launch
const STARSHIP_CACHE = 'C:\Users\skyle\AppData\Local\Cache\starship\init.nu'
source $STARSHIP_CACHE

# Atuin Launch
const ATUIN_INIT_SCRIPT = 'C:\Users\skyle\AppData\Local\Cache\atuin\atuin_init.nu'
source $ATUIN_INIT_SCRIPT

# Aliases
alias cfg = cd $env.XDG_CONFIG_HOME

# Commands
# Generates a persistent Windows shim using safe path joining to avoid escape collisions
def make-shim [
    name: string,     # The name of the shim (e.g., 'gsudo')
    target: string,   # The full path to the executable
    workdir: string   # The directory the command should "start" in
] {
    # Define the base directory using single quotes to treat backslashes as raw literals
    let shim_dir = 'C:\bin'

    # Use 'path join' for mechanical safety and OS parity
    let shim_path = ($shim_dir | path join $"($name).bat")

    # Construct the batch content with explicit carriage returns for CMD compatibility
    let content = $"@echo off\r\npushd \"($workdir)\"\r\n\"($target)\" %*\r\npopd"

    $content | save --force $shim_path
    print $"Shim created at ($shim_path). You can now run '($name)'."
}
