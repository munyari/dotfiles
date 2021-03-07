# This file has been generated by ./pkgs/misc/vim-plugins/update.py. Do not edit!
{ lib, buildVimPluginFrom2Nix, fetchFromGitHub, overrides ? (self: super: {}) }:
let
  packages = ( self:
{
  nord-vim = buildVimPluginFrom2Nix {
    pname = "nord-vim";
    version = "2020-07-06";
    src = fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-vim";
      rev = "57dffa746907e8ce5c4b520146ed0d89d3c29a51";
      sha256 = "0xpz71rj74514789v6x9wrg95n8bsag8f5ygd7js40qrwpxq6b4j";
    };
    meta.homepage = "https://github.com/arcticicestudio/nord-vim/";
  };

  nvim-colorizer-lua = buildVimPluginFrom2Nix {
    pname = "nvim-colorizer-lua";
    version = "2020-06-11";
    src = fetchFromGitHub {
      owner = "norcalli";
      repo = "nvim-colorizer.lua";
      rev = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6";
      sha256 = "0gvqdfkqf6k9q46r0vcc3nqa6w45gsvp8j4kya1bvi24vhifg2p9";
    };
    meta.homepage = "https://github.com/norcalli/nvim-colorizer.lua/";
  };

  nvim-fzf = buildVimPluginFrom2Nix {
    pname = "nvim-fzf";
    version = "2021-01-08";
    src = fetchFromGitHub {
      owner = "vijaymarupudi";
      repo = "nvim-fzf";
      rev = "3a08f000163a5ddc41f7922dd95a082fb50b9899";
      sha256 = "0fgnhvwl970pyz369mgqlyx67s93i80mg9k7miifg2n0zdd3jqbc";
    };
    meta.homepage = "https://github.com/vijaymarupudi/nvim-fzf/";
  };

  nvim-fzf-commands = buildVimPluginFrom2Nix {
    pname = "nvim-fzf-commands";
    version = "2021-01-23";
    src = fetchFromGitHub {
      owner = "vijaymarupudi";
      repo = "nvim-fzf-commands";
      rev = "c9117a12836482263c6554a2700825c875ee6ca6";
      sha256 = "11fvfc6a4izh38qpwqgpf78rmfrgin374rky5csdifixasn88abi";
    };
    meta.homepage = "https://github.com/vijaymarupudi/nvim-fzf-commands/";
  };

});
in lib.fix' (lib.extends overrides packages)
