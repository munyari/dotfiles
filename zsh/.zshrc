#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# run startx at login
if [[ $(tty) == /dev/tty1 ]]; then
  exec startx
fi

# auto attach tmux session when shell is opened
_not_inside_tmux() {
  [[ -z "$TMUX" ]]
}

ensure_tmux_is_running() {
  if [[ $(tty) != /dev/tty1 ]] && _not_inside_tmux && type tat > /dev/null 2>&1; then
    tat
  fi
}

ensure_tmux_is_running

if  type chruby > /dev/null 2>&1; then
  source /usr/share/chruby/chruby.sh
  source /usr/share/chruby/auto.sh
  chruby 2.3.0
fi

# shell utility functions
[[ -f ~/.utils ]] && source ~/.utils

# aliases
[ -f ~/.aliases ] && source ~/.aliases

# allow editing the command line with editor
autoload edit-command-line
zle -N edit-command-line
#
# bound to Esc v in vi mode
bindkey -M vicmd v edit-command-line

# Set GPG TTY
export GPG_TTY=$(tty)

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

# The following lines were added by compinstall
zstyle :compinstall filename '/home/nash/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Complete g like git
compdef g=git

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval $(dircolors -b /usr/share/LS_COLORS)

# syntax highlighting in z shell
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
