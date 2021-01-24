#
# Editors
#

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
cdpath=(
  $PWD
  $HOME/code
  $HOME/src/server
  $HOME
  $cdpath
)

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/.local/bin
  /opt/dropbox-override/bin
  $HOME/.emacs.d/bin
  $HOME/.yarn/bin
  $HOME/.stack/snapshots/x86_64-linux-ncurses6/lts-6.7/7.10.3/bin
  $HOME/.stack/programs/x86_64-linux/ghc-ncurses6-7.10.3/bin
  $HOME/.cargo/bin
  $HOME/.gem/ruby/2.{4,3}.0/bin
  /usr/local/opt/node@10/bin
  $VIMCONFIG/pack/bundle/start/fzf/bin
  /Library/Frameworks/Python.framework/Versions/3.6/bin
  /usr/local/opt/python@2/libexec/bin
  /usr/local/{bin,sbin}
  $path
  $HOME/miniconda3/bin
  $HOME/miniconda2/bin
)

# set command line history
export HISTFILE=~/.zhistory
export HISTSIZE=10000
export SAVEHIST=10000
#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4 --RAW-CONTROL-CHARS'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

# XDG directory defaults
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# default terminal to use in wayland
export WAYLAND_TERMINAL="alacritty"

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='fd .'

export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.

# other configuration
export VIMCONFIG="$HOME/.config/nvim"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export PC="//services/metaserver"
