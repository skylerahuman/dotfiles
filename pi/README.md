# Pi configuration

This directory is the source of truth for Pi configuration on both Windows and Arch WSL.

Runtime config links:

- Windows: `C:\Users\skyle\.pi\agent\settings.json` is a hardlink to `agent/settings.json`.
- Windows: `C:\Users\skyle\.pi\agent\themes` is a junction to `agent/themes`.
- Arch WSL: `/home/sky/.pi/agent/settings.json` is a symlink to this repo's `agent/settings.json`.
- Arch WSL: `/home/sky/.pi/agent/themes` is a symlink to this repo's `agent/themes`.

Shared session state:

- Windows: `C:\Users\skyle\.pi\agent\sessions` is a junction to `C:\Users\skyle\AppData\Local\State\pi-agent\sessions`.
- Arch WSL: `/home/sky/.pi/agent/sessions` is a symlink to `/mnt/c/Users/skyle/AppData/Local/State/pi-agent/sessions`.

Auth state, intentionally **not tracked**:

- Windows keeps auth in local state: `C:\Users\skyle\AppData\Local\State\pi-agent\auth.json`.
- Arch WSL should keep its own auth on the Linux filesystem, e.g. `/home/sky/.pi/agent/auth.json`.

Do not share or track OAuth tokens/API keys. Sharing sessions is safe/useful, but sharing OAuth auth across Windows and Linux can be unreliable because tokens/locks may be platform-specific.

Edit themes/settings here, then both OSes see the change.
