# Dotfiles and Arch Install Script

## Arch Install Script

Install git (`pacman -Syy git`) after booting from ISO.
Clone this repo.
Create all the necessary partitions, format them and set them up in `./setup/config.sh` along with all the other settings.
Then run `setup/01-start-setup.sh`, and it'll take care of mounting the partitions,
installing arch, setting up the user, networking, desktop environment, etc,.

## Dotfiles

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
cd home

# single config
stow -t $HOME zsh
# multiple at a time
stow -t $HOME vim git tmux
# all the configs
stow -t $HOME */
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

