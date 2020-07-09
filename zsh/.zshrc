setopt autocd

function is_macos() {
  [[ "$(uname)" == "Darwin" ]]
}

# run startx at login
if [[ $(tty) == /dev/tty1 ]]; then
  exec startx
fi

# shell utility functions
[[ -f ~/.utils ]] && source ~/.utils

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# allow editing the command line with editor
autoload edit-command-line
zle -N edit-command-line

# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Complete g like git
compdef g=git

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

[[ -f /usr/share/LS_COLORS ]] && eval $(dircolors -b /usr/share/LS_COLORS)

# By doing this, only the past commands matching the current line up to the
# current cursor position will be shown when Up or Down keys are pressed.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# emacs mode!
bindkey -e

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
