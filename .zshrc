# Orange Cracker ZSH configuration

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt share_history

# Plugins
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# Prompt
setopt prompt_subst
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%F{208} %b%f'
PROMPT='%F{166}%n%f %F{208}■%f %F{166}%1~%f ${vcs_info_msg_0_}%f\n$ '

# Aliases
alias ytfzf='ytfzf'
alias ytmusic='ytmusic-tui'
alias yazi='yazi'
alias navi='navi'
alias cg='cargo'
alias ai='tmux attach -t ai 2>/dev/null || tmux new -s ai'

# Automatically invoke tmux on shell startup if not already inside
if [[ -z $TMUX ]]; then
  ai
fi

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"

export VISUAL=nvim
export EDITOR="$VISUAL"
