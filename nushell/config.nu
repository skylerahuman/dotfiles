# config.nu
#
# Installed by:
# version = "0.112.2"

# Starship Launch
source ~/.cache/starship/init.nu

# Atuin Launch
source ~/.cache/atuin/atuin_init.nu

# Aliases
alias cfg = cd $env.XDG_CONFIG_HOME

# Commands
# Generates a persistent shim using safe path joining to avoid escape collisions.
def make-shim [
    name: string,     # The name of the shim (e.g., 'gsudo')
    target: string,   # The full path to the executable
    workdir: string   # The directory the command should "start" in
] {
    let shim_dir = if $nu.os-info.name == "windows" { 'C:\bin' } else { $"($env.HOME)/.local/bin" }
    let shim_path = ($shim_dir | path join (if $nu.os-info.name == "windows" { $"($name).bat" } else { $name }))

    if $nu.os-info.name == "windows" {
        let content = $"@echo off\r\npushd \"($workdir)\"\r\n\"($target)\" %*\r\npopd"
        $content | save --force $shim_path
    } else {
        let content = $"#!/usr/bin/env bash\ncd \"($workdir)\"\nexec \"($target)\" \"$@\"\n"
        $content | save --force $shim_path
        chmod +x $shim_path
    }

    print $"Shim created at ($shim_path). You can now run '($name)'."
}
