# Dotfiles

These are the configuration files that I use on my Linux box (currently
ArchLinux). I hope to make these somewhat platform agnostic, as well as unify
my Neovim and Vim configurations.

## Getting started

### Requirements

[GNU Stow](https://www.gnu.org/software/stow/) (available in [Arch's community
repo](https://www.archlinux.org/packages/community/any/stow/).

### Instructions

In zsh, run

```zsh
stow *(/)
```

Stow will set up all the necessary sym-links, and you should be ready to go!

## Issues

- Write a script that allows you to choose between minimal and more
  full-featured installations.
- Include installed packages
- Include /etc (through etckeeper)
- First move target files before stowing (avoid the warnings)
