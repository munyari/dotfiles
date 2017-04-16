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
  if _not_inside_tmux && type tat > /dev/null 2>&1; then
    tat
  fi
}

ensure_tmux_is_running

# Complete g like git
compdef g=git

if  type chruby > /dev/null 2>&1; then
  source /usr/share/chruby/chruby.sh
  source /usr/share/chruby/auto.sh
  chruby 2.3.0
fi

# shell utility functions
[[ -f ~/.utils ]] && source ~/.utils

# aliases
[ -f ~/.aliases ] && source ~/.aliases

# SSH_ENV="$HOME/.ssh/environment"

# start_agent() {
#   echo "Initialising new SSH agent..."
#   # >! is zsh-syntax to clobber with noclobber set (>| in bash)
#   /usr/bin/ssh-agent | sed 's/^echo/#echo/' >! "${SSH_ENV}"
#   echo succeeded
#   chmod 600 "${SSH_ENV}"
#   . "${SSH_ENV}" > /dev/null
#   /usr/bin/ssh-add -t 7200w;
# }

# # Source SSH settings, if applicable

# if [ -f "${SSH_ENV}" ]; then
#   . "${SSH_ENV}" > /dev/null
#   #ps ${SSH_AGENT_PID} doesn't work under cywgin
#   ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#   start_agent;
# }
# else
#   start_agent;
# fi

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

eval $(dircolors -b /usr/share/LS_COLORS)

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
