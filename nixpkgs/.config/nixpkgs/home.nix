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
  customPlugins = pkgs.callPackage ./config/nvim-plugins.nix {
    lib = pkgs.lib;
    buildVimPluginFrom2Nix = pkgs.vimUtils.buildVimPluginFrom2Nix;
  };
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
      coreutils
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
      jq
      less
      mosh
      mpv
      ncdu # ncurses disk space visualizer
      neovim-remote
      nixfmt
      nodejs
      noti # useful for notification of long-running commands
      pandoc
      python
      python3
      ripgrep
      rsync
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

  # TODO: look at targets.darwin configuration
  home.sessionPath = [ "/opt/dropbox-override/bin" ];

  programs.bat = {
    enable = true;
    config = {
      map-syntax = "BUILD.in:Python";
      theme = "Nord";
    };
  };

  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    extraConfig = import ./config/LS_COLORS.nix;
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
          background = "#2e3440";
          foreground = "#d8dee9";
          dim_foreground = "#a5abb6";
        };
        cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        vi_mode_cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        selection = {
          text = "CellForeground";
          background = "#4c566a";
        };
        search = {
          matches = {
            foreground = "CellBackground";
            background = "#88c0d0";
          };
          bar = {
            background = "#434c5e";
            foreground = "#d8dee9";
          };
        };

        normal = {
          black = "#3b4252";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#88c0d0";
          white = "#e5e9f0";
        };

        bright = {
          black = "#4c566a";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#8fbcbb";
          white = "#eceff4";
        };
        dim = {
          black = "#373e4d";
          red = "#94545d";
          green = "#809575";
          yellow = "#b29e75";
          blue = "#68809a";
          magenta = "#8c738c";
          cyan = "#6d96a5";
          white = "#aeb3bb";
        };
      };
    };
  };

  # TODO: configure difftool to work with nvim -d and nvr
  programs.git = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then
      pkgs.writeShellScriptBin "git" ''/opt/dropbox-override/bin/git "$@"''
    else
      pkgs.git;
    aliases = {
      a = "add";
      ab = "!arc branch --by-status";
      ap = "add --patch";
      b = "branch";
      bD = "branch -D";
      bd = "branch -d";
      branches = "branch -av";
      can = "commit --amend --no-edit";
      cm = "commit -m";
      co = "checkout";
      cob = "checkout -b";
      d = "diff";
      dc = "diff --cached";
      dw = "diff --word-diff";
      glog = "log -E -i --grep";
      l = "log --oneline --decorate --graph --all -20";
      last = "log -1 HEAD";
      ls = "log --oneline --graph --decorate --simplify-by-decoration";
      p = "push";
      publish = "!git push -u origin $(git branch-name)";
      r = "rebase";
      rc = "rebase --continue";
      remotes = "remote -v";
      ri = "rebase -i";
      stashes = "stash list";
      su = "stash -u";
      tags = "tag";
      unchange = "reset --hard";
      uncommit = "reset --soft HEAD^";
      unpublish = "!git push origin :$(git branch-name)";
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
      branch.autoSetupMerge = "always";
      core = {
        compression = 0;
        looseCompression = 0;
        whitespace = "space-before-tab, tab-in-indent, trailing-space";
      };
      color.ui = "auto";
      commit.verbose = true;
      dbx.messagedisplayversion = 1;
      fetch.prune = true;
      grep.extendedRegexp = true;
      rebase = {
        autostash = true;
        abbreviateCommands = true;
      };
      pull.rebase = true;
      push.default = "upstream";
      merge = { renamelimit = 1815; };
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
    userEmail = "panashe@dropbox.com";
    userName = "Panashe M. Fundira";
  };

  programs.htop = {
    enable = true;
    hideThreads = true;
    hideKernelThreads = true;
    colorScheme = 6;
    treeView = true;
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = true;
    extraConfig = import ./config/neovim.nix;
    plugins = with pkgs.vimPlugins;
      [
        Tabular
        commentary
        deoplete-lsp
        deoplete-nvim
        fugitive
        fzf-vim
        fzf-lsp-nvim
        gitgutter
        nvim-lspconfig
        nvim-treesitter
        surround
      ] ++ (with customPlugins; [
        # TODO: bring the generator into this repo too
        nord-vim
        nvim-colorizer-lua
        nvim-fzf
        nvim-fzf-commands
      ]);
  };

  programs.ssh = {
    enable = true;
    extraConfig = import ./config/ssh.nix;
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
      # Set the default Less options.
      # Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
      # Remove -X and -F (exit if the content fits on one screen) to enable it.
      LESS = "-F -g -i -M -R -S -w -X -z-4 --RAW-CONTROL-CHARS";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };

    shellGlobalAliases = {
      bzl = "mbzl";
      less = "bat";
      ls = "ls --color=auto";
    };
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];
}
