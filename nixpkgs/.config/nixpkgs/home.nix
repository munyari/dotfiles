{ config, pkgs, ... }:

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

  home.packages = [
    pkgs.bash
    pkgs.black
    pkgs.chicken
    pkgs.ctags
    pkgs.curl
    pkgs.fd
    pkgs.fzf
    pkgs.gnupg
    pkgs.gnused
    pkgs.gnutar
    pkgs.go
    pkgs.gopls
    pkgs.htop
    pkgs.jq
    pkgs.less
    pkgs.mosh
    pkgs.mpv
    pkgs.neovim-remote
    pkgs.nodejs
    pkgs.pandoc
    pkgs.python
    pkgs.python3
    pkgs.ripgrep
    pkgs.ruby
    pkgs.stack
    pkgs.stow
    pkgs.tmux
    pkgs.tree
    pkgs.wget
    pkgs.which
    pkgs.youtube-dl
    pkgs.zsh
  ];

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.magit
    ];
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimdiffAlias = true;
  };
  xdg.configFile."nvim/init.lua".source = ~/dotfiles/nvim/.config/nvim/init.lua;
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];
}
