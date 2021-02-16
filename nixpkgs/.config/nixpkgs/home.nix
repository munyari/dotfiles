{ config, pkgs, ... }:

let
  rSERVER = "~/src/server";
  # TODO: pin a commit for neovim
  nixGLIntel = (pkgs.callPackage "${
      builtins.fetchTarball {
        url =
          "https://github.com/guibou/nixGL/archive/7d6bc1b21316bab6cf4a6520c2639a11c25a220e.tar.gz";
        sha256 = "02y38zmdplk7a9ihsxvnrzhhv7324mmf5g8hmxqizaid5k5ydpr3";
      }
    }/nixGL.nix" { }).nixGLIntel;
in {
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

  home.packages = with pkgs;
    [
      bash
      black
      cachix
      chicken
      ctags
      curl
      delta # better diffs
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
      ncdu # ncurses disk space visualizer
      neovim-remote
      nixfmt
      nodejs
      pandoc
      python
      python3
      ripgrep
      ruby
      stack
      stow
      tree
      wget
      which
      youtube-dl
    ] ++ (if pkgs.stdenv.isLinux then
      [
        qemu # virtual machine go brr
      ]
    else
      [ ]);

  programs.bat = {
    enable = true;
    config = { map-syntax = "BUILD.in:Python"; };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    defaultCommand = "fd";
  };

  programs.alacritty = {
    enable = true;
    package = if pkgs.stdenv.isLinux then
      pkgs.writeShellScriptBin "alacritty"
      ''${nixGLIntel}/bin/nixGLIntel ${pkgs.alacritty}/bin/alacritty "$@"''
    else
      pkgs.alacritty;
    settings = {
      font = {
        normal.family = "Fira Code";
        size = 15.0;
        use_thin_strokes = true;
      };

      colors = {
        primary = {
          background = "0x0a0f14";
          foreground = "0x98d1ce";
        };

        normal = {
          black = "0x0a0f14";
          red = "0xc33027";
          green = "0x26a98b";
          yellow = "0xedb54b";
          blue = "0x195465";
          magenta = "0x4e5165";
          cyan = "0x33859d";
          white = "0x98d1ce";
        };

        bright = {
          black = "0x10151b";
          red = "0xc23127";
          green = "0x2aa889";
          yellow = "0xedb443";
          blue = "0x093748";
          magenta = "0x888ca6";
          cyan = "0x599caa";
          white = "0xd3ebe9";
        };
      };
    };
  };

  programs.git = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then
      pkgs.writeShellScriptBin "git" ''/opt/dropbox-override/bin/git "$@"''
    else
      pkgs.git;
    aliases = {
      a = "add";
      ap = "add --patch";
      b = "branch";
      bd = "branch -d";
      branches = "branch -av";
      can = "commit --amend --no-edit";
      co = "checkout";
      cob = "checkout -b";
      cm = "commit -m";
      d = "diff";
      dc = "diff --cached";
      glog = "log -E -i --grep";
      l = "log --oneline --decorate --graph --all -20";
      last = "log -1 HEAD";
      p = "push";
      stashes = "stash list";
      su = "stash -u";
      unchange = "checkout --";
      uncommit = "reset --soft HEAD^";
      unstage = "reset HEAD --";
    };
    attributes = [
      # better diffs by language
      "*.c     diff=cpp"
      "*.c++   diff=cpp"
      "*.cc    diff=cpp"
      "*.cpp   diff=cpp"
      "*.cs    diff=csharp"
      "*.css   diff=css"
      "*.el    diff=lisp"
      "*.ex    diff=elixir"
      "*.exs   diff=elixir"
      "*.go    diff=golang"
      "*.h     diff=cpp"
      "*.h++   diff=cpp"
      "*.hh    diff=cpp"
      "*.hpp   diff=cpp"
      "*.html  diff=html"
      "*.java  diff=java"
      "*.lisp  diff=lisp"
      "*.m     diff=objc"
      "*.md    diff=markdown"
      "*.mm    diff=objc"
      "*.php   diff=php"
      "*.pl    diff=perl"
      "*.py    diff=python"
      "*.rake  diff=ruby"
      "*.rb    diff=ruby"
      "*.rs    diff=rust"
      "*.sh    diff=bash"
      "*.tex   diff=tex"
      "*.xhtml diff=html"

      # don't show me generated protobufs
      "*pb2.py -diff linguist-generated=true"
      "*pb2.pyi -diff linguist-generated=true"
      "*pb2_grpc.py -diff linguist-generated=true"
      "*pb2_grpc.pyi -diff linguist-generated=true"
      "*.pb.go -diff linguist-generated=true"
    ];
    delta = {
      enable = true;
      options = { features = "line-numbers"; };
    };
    extraConfig = {
      color.ui = "auto";
      push.default = "upstream";
      fetch.prune = true;
    };
    ignores = [
      # Compiled source #
      ####################
      "*.com"
      "*.class"
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"
      "*.beam"
      "*.pdf"

      # Packages #
      ############
      # it's better to unpack these files and commit the raw source
      # git has its own built in compression methods
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.zip"

      ## Logs and databases #
      #######################
      "*.log"
      "*.sql"
      "*.sqlite"

      ## OS generated files #
      #######################
      ".DS_Store"
      ".DS_Store?"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"

      # vim swap files #
      ##################
      "*~"

      # tag files #
      #############
      "tags"

      ## build artifacts #
      ####################
      "*.aux"
      "*.out"
      ".stack-work/"
      "*.hi"
      "*.o"

      "node_modules/"
      ".ropeproject/"
    ];
    userEmail = "panashe@hey.com";
    userName = "Panashe M. Fundira";
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
    cdpath = [ "." "~" rSERVER ];

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
    initExtra = import ./config/zsh/initExtra.nix;

    sessionVariables = {
      PATH = "/opt/dropbox-override/bin:$PATH";
      # Set the default Less options.
      # Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
      # Remove -X and -F (exit if the content fits on one screen) to enable it.
      LESS = "-F -g -i -M -R -S -w -X -z-4 --RAW-CONTROL-CHARS";
    };

    shellGlobalAliases = {
      bzl = "mbzl";
      less = "bat";
    };
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];
}
