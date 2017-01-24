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
  if _not_inside_tmux; then
    tat
  fi
}

ensure_tmux_is_running

# Complete g like git
compdef g=git

source /usr/share/chruby/chruby.sh
source /usr/share/chruby/auto.sh
chruby 2.3.0

# shell utility functions
if [ -f ~/.utils ]; then
  source ~/.utils
fi

# aliases
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

# Gotham Shell
# GOTHAM_SHELL="$HOME/.config/gotham/gotham.sh"
# [[ -s $GOTHAM_SHELL ]] && source $GOTHAM_SHELL

SSH_ENV="$HOME/.ssh/environment"

start_agent() {
    echo "Initialising new SSH agent..."
    # >! is zsh-syntax to clobber with noclobber set (>| in bash)
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' >! "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add -t 7200;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  #ps ${SSH_AGENT_PID} doesn't work under cywgin
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
  start_agent;
}
else
  start_agent;
fi

# syntax highlighting in z shell
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f /home/nash/Downloads/google-cloud-sdk/path.zsh.inc ]; then
  source '/home/nash/Downloads/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /home/nash/Downloads/google-cloud-sdk/completion.zsh.inc ]; then
  source '/home/nash/Downloads/google-cloud-sdk/completion.zsh.inc'
fi