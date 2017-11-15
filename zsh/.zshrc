setopt autocd

function is_macos() {
  [[ "$(uname)" == "Darwin" ]]
}

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

# shell utility functions
[[ -f ~/.utils ]] && source ~/.utils

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# allow editing the command line with editor
autoload edit-command-line
zle -N edit-command-line


if is_macos; then
  ZPLUG_DIR=/usr/local/opt/zplug
else
  ZPLUG_DIR=/usr/share/zsh/scripts/zplug
fi
source $ZPLUG_DIR/init.zsh
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug zdharma/fast-syntax-highlighting, from:github
zplug plugins/archlinux, from:oh-my-zsh
zplug plugins/gpg-agent, from:oh-my-zsh
zplug load

is_macos && PURE_GIT_PULL=0

#
# bound to Esc v in vi mode
bindkey -M vicmd v edit-command-line

# # assume we're running linux
# if [[ ! "$(uname -s)" == "Darwin" ]]; then
#   # Set GPG TTY
#   export GPG_TTY=$(tty)

#   # Start the gpg-agent if not already running
#   if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
#     gpg-connect-agent /bye >/dev/null 2>&1
#   fi

#   OSCPKCS11=/usr/lib/ssh-keychain.dylib
#   [[ -e $OSCPKCS11 ]] && export OSCPKCS11

#   # Refresh gpg-agent tty in case user switches into an X session
#   gpg-connect-agent updatestartuptty /bye >/dev/null
# fi


# The following lines were added by compinstall
zstyle :compinstall filename '/home/nash/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Complete g like git
compdef g=git

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

[[ -f /usr/share/LS_COLORS ]] && eval $(dircolors -b /usr/share/LS_COLORS)

[[ -e "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"

bindkey -v
bindkey -a "?" history-incremental-search-backward
bindkey -a "/" history-incremental-search-forward

# By doing this, only the past commands matching the current line up to the
# current cursor position will be shown when Up or Down keys are pressed.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search
