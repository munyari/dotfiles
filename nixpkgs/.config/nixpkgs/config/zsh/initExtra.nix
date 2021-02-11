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
''
