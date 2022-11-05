# Dotfiles

Managed with GNU stow.
If you'd like to try these, first install `stow`
(available for most *nix distributions)

### Install stow
- `apt install stow`
- `brew install stow`
- `pacman -S stow` 

### Clone the dotfiles
To clone the dotfiles:
```sh
git clone https://github.com/AnirudhKonduru/dotfiles ~/dotfiles
cd ~/dotfiles
```

### Symlink the configs
Finally, symlink the config files for your user using:
```sh
# single config
stow zsh
# multiple at a time
stow vim git tmux
# all the configs
stow */
```
To install to the root user instead:
```sh
stow zsh -t /root/
```

### Uninstall a config:
```sh
stow -D zsh
```


Wallpaper by rootkit from https://wallhaven.cc/w/k7v9yq

