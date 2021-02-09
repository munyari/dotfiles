{ config, pkgs, ... }:

let
  rSERVER = "~/src/server";
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "panashe";
  home.homeDirectory = "/Users/panashe";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";

  home.packages = with pkgs; [
    bash
    black
    cachix
    chicken
    ctags
    curl
    delta    # better diffs
    fd
    ffmpeg
    gnupg
    gnused
    gnutar
    go
    gopls
    htop
    jq
    less
    mosh
    mpv
    neovim-remote
    nodejs
    pandoc
    python
    python3
    qemu # virual machine go brrr
    ripgrep
    ruby
    stack
    stow
    tree
    wget
    which
    youtube-dl
  ];

  programs.alacritty.enable = true;

  programs.bat = {
    enable = true;
    config = {
      map-syntax = "BUILD.in:Python";
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    defaultCommand = "fd";
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimdiffAlias = true;
    withPython3 = true;
    extraConfig = import ./config/neovim.nix;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    defaultKeymap = "emacs";
    enableCompletion = true;
    autocd = true;
    cdpath = [
      "."
      "~"
      rSERVER
    ];

    history = {
      expireDuplicatesFirst = true;
      extended = true; # save timestamps in history file
      ignoreDups = true; # don't enter a line if it's already in history
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./config/zsh;
        file = "p10k.zsh";
      }
    ];

    initExtra = "source $HOME/.nix-profile/etc/profile.d/nix.sh";

    sessionVariables = {
      EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'";
      VISUAL = "$EDITOR";
      PATH = "/opt/dropbox-override/bin:$PATH";
      # Set the default Less options.
      # Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
      # Remove -X and -F (exit if the content fits on one screen) to enable it.
      LESS="-F -g -i -M -R -S -w -X -z-4 --RAW-CONTROL-CHARS";
    };

    shellGlobalAliases = {
      n = "nvim";
      g = "git";
    };
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];
}
