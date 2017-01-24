# script for git completion
if [ -f ~/git-completion.bash ]; then
  source ~/.git-completion.bash
fi
# aliases
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

# environment variables
if [ -f ~/.env_var ]; then
  source ~/.env_var
fi

# run startx at login
if [[ $(tty) == /dev/tty1 ]]; then
  exec startx
fi
# Run twolfson/sexy-bash-prompt
if [ -f ~/.bash_prompt ]; then
  source ~/.bash_prompt
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

# TODO: extract such utilities to own script and bring under VC
weather() {
  curl "http://wttr.in/$1"
}

source /usr/share/chruby/chruby.sh
source /usr/share/chruby/auto.sh
chruby 2.3.0

eval $(dircolors -b $HOME/.dircolors)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash