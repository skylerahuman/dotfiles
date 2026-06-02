#!/usr/bin/env bash
set -euo pipefail

agent_dir="$HOME/.pi/agent"
mkdir -p "$agent_dir"

# Pi/proper-lockfile uses lock *directories* such as auth.json.lock.
# A regular file at that path breaks auth loading with ENOTDIR, so remove stale files/links.
for lock in "$agent_dir/auth.json.lock" "$agent_dir/settings.json.lock"; do
  if [ -e "$lock" ] || [ -L "$lock" ]; then
    rm -rf "$lock"
  fi
done

# Auth should be local to Arch and untracked. If an old shared symlink exists, remove it.
if [ -L "$agent_dir/auth.json" ]; then
  rm -f "$agent_dir/auth.json"
fi

# Restore the previous Arch-local auth if it exists; otherwise leave auth absent so Pi can create it on login.
if [ -f "$agent_dir/auth.json.arch-local-backup" ] && [ ! -f "$agent_dir/auth.json" ]; then
  mv "$agent_dir/auth.json.arch-local-backup" "$agent_dir/auth.json"
fi

# Ensure any Arch-local auth has private Linux-side permissions.
if [ -f "$agent_dir/auth.json" ]; then
  chmod 600 "$agent_dir/auth.json"
fi

printf 'Arch Pi auth is local and untracked at %s/auth.json\n' "$agent_dir"
printf 'Stale regular lock files have been removed. Do not create auth.json.lock manually.\n'
printf 'If Pi still asks for login, login once from Arch; it should then persist across Arch sessions.\n'
