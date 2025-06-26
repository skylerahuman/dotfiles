#!/bin/sh
set -e

mkdir -p "$HOME/.config"
for d in alacritty hypr waybar yazi ytmusic-tui ytfzf greetd nvim; do
  mkdir -p "$HOME/.config/$d"
  [ -d "config/$d" ] && for f in config/$d/*; do
    ln -sf "$PWD/$f" "$HOME/.config/$d/"
  done
done

ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
ln -sf "$PWD/.p10k.zsh" "$HOME/.p10k.zsh"

printf '\nDotfiles linked. Install packages: zsh alacritty hyprland tuigreet waybar.\n'
