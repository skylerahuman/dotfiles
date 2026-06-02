# Pi configuration

Pi's Arch runtime config is intentionally linked to the Windows dotfiles/state layout:

- Settings: `/home/sky/.pi/agent/settings.json` -> `/mnt/c/Users/skyle/AppData/Config/pi/agent/settings.json`
- Themes: `/home/sky/.pi/agent/themes` -> `/mnt/c/Users/skyle/AppData/Config/pi/agent/themes`
- Sessions: `/home/sky/.pi/agent/sessions` -> `/mnt/c/Users/skyle/AppData/Local/State/pi-agent/sessions`
- Auth, untracked: `/home/sky/.pi/agent/auth.json` -> `/mnt/c/Users/skyle/AppData/Local/State/pi-agent/auth.json`

Edit Pi themes/settings from Windows at `C:\Users\skyle\AppData\Config\pi`.
Do not put OAuth tokens or API keys in this repo.
