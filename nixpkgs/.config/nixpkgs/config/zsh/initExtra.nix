let
  metaserver_target = "//services/metaserver";
in
''
# vim:ft=zsh
source $HOME/.nix-profile/etc/profile.d/nix.sh
# No arguments: `git status` With arguments: acts like `git`
function g() {
  if [[ $# > 0 ]]
  then
    git "$@"
  else
    git status --short --branch
  fi
}
# use git completions
compdef g=git

function n() { eval "$EDITOR" "$@" }

function bzl() { mbzl --use-fsnotify "$@" }

function sms() {
  bzl itest-start "${metaserver_target}" "$@"
}

function sam() {
  bzl itest-stop-all --force "$@"
}

function rms() {
  bzl itest-reload-current "$@" || (sam && sms)
  osascript -e 'display notification "Hooray!" with title "Devbox has finished building!"'
  auto-reload-meta
}

function tail_metaserver() {
    mbzl itest-exec "${metaserver_target}" -- tail -f /tmp/bzl/logs/service_logs/metaserver/metaserver_core/service.log
}

if [[ $NVIM_LISTEN_ADDRESS ]]
then
  export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
  export EDITOR="nvim"
fi

export VISUAL="$EDITOR"

# ================== edit above this line ==========================================
''

