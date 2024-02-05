#!/usr/bin/env sh

set -euxo pipefail

# make sure this isn't run as root
if [ "$(id -u)" = "0" ]; then
	echo "This script should not be run as root, exiting..."
	exit 1
fi

# setup dotfiles
rm -rf ~/dotfiles/
git clone https://github.com/AnirudhKonduru/dotfiles.git ~/dotfiles
cd ~/dotfiles/home && stow */ -t "$HOME" && cd ~

chmod 755 ~/.config/bspwm/bspwmrc
chmod 644 ~/.config/sxhkd/sxhkdrc

### install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly
. "$HOME"/.cargo/env

### install paru
cargo install paru

### install pulseaudio-control
paru -S --noconfirm --needed pulseaudio-control

### install some preferred fonts (see fontconfig/fonts.conf)
paru -S --noconfirm --needed ttf-cascadia-code-nerd ttf-jetbrains-mono-nerd ttf-firacode-nerd

