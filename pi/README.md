# Pi configuration

Pi's Arch runtime config is intentionally linked to the Windows dotfiles/state layout where appropriate:

- Settings: `/home/sky/.pi/agent/settings.json` -> `/mnt/c/Users/skyle/AppData/Config/pi/agent/settings.json`
- Themes: `/home/sky/.pi/agent/themes` -> `/mnt/c/Users/skyle/AppData/Config/pi/agent/themes`
- Sessions: `/home/sky/.pi/agent/sessions` -> `/mnt/c/Users/skyle/AppData/Local/State/pi-agent/sessions`

Auth is intentionally **not tracked** and should be per-OS. Arch should keep its own OAuth state on the Linux filesystem, e.g. `/home/sky/.pi/agent/auth.json`, instead of sharing the Windows auth file.

Edit Pi themes/settings from Windows at `C:\Users\skyle\AppData\Config\pi`.
Do not put OAuth tokens or API keys in this repo.
