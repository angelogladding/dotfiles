# dotfiles

Configuration files for `autostart`, `devilspie2`, `dircolors`, `git`, `nvim`, `openvpn`, `pypoetry`, `tmux` and `zsh`.

## Prerequisites

You must have `stow` installed.

### Debian

```shell
apt install stow
```

### Mac OS

```shell
brew install stow
```

## Install

```shell
git clone git@github.com:angelogladding/logfiles.git .logfiles
git clone git@github.com:angelogladding/authfiles.git .authfiles
git clone git@github.com:angelogladding/fontfiles.git .fontfiles
git clone --recurse-submodules git@github.com:angelogladding/dotfiles.git .dotfiles
cd .dotfiles
sh install.sh
```
