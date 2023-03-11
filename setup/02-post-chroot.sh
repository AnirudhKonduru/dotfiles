#!/usr/bin/env sh

set -euxo pipefail

# pacman options
PACMAN="pacman --needed --noconfirm -Sq"

export DIR=/dotfiles/setup
# load the config file
. "$DIR/config.sh"

# check if the config file was loaded
if [ "$CONFIG_LOADED" != "true" ]; then
	echo "Config file not loaded, exiting..."
	exit 1
fi

echo "HOST = '$HOST', NEW_USER = '$NEW_USER', continuing... in 5 seconds"
sleep 5

echo "Setting up root password"
echo "root:$ROOT_PASSWORD" | chpasswd

# set the timezone
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# set up locale
sed -i '/en_US.UTF-8 UTF-8/s/^#*//g' /etc/locale.gen
locale-gen

echo $HOST >>/etc/hostname

# set up LANG variable
echo "LANG=en_US.UTF-8" >>/etc/locale.conf
export LANG=en_US.UTF-8

# set up hosts file
tee -a /etc/hosts <<EOF
127.0.0.1    localhost
::1          localhost
127.0.0.1   $HOST
EOF

# install grub
$PACMAN grub efibootmgr

# setup boot partition
mkdir -p /boot/efi

# install grub to the disk
grub-install --target=x86_64-efi --bootloader-id=grub --efi-directory=/boot/efi

# generate grub config
grub-mkconfig -o /boot/grub/grub.cfg

# install some essentials
$PACMAN base-devel stow neovim tmux git openssh wget curl which vim zsh sudo pacman

# create user with home directory and shell set to zsh
if ! id -u "$NEW_USER" >/dev/null 2>&1; then
	useradd -m -G wheel -s /bin/zsh $NEW_USER
else
	echo "User $NEW_USER already exists, skipping creation"
fi

# set the user's password
echo "$NEW_USER:$USER_PASSWORD" | chpasswd

on_exit() {
	echo "Exiting, and resetting sudoers file to remove NOPASSWD for wheel group"
	echo '/^\(%wheel\s*ALL=(ALL\(:ALL\|\))\s*NOPASSWD:\s*ALL\)/ s/^/# /' | EDITOR='sed -f- -i' visudo
}
trap on_exit EXIT

# set up sudo - uncomment the wheel group in sudoers file
echo 's/^#\s*\(%wheel\s*ALL=(ALL\(:ALL\|\))\s*ALL\)/\1/g' | EDITOR='sed -f- -i' visudo
echo 's/^#\s*\(%wheel\s*ALL=(ALL\(:ALL\|\))\s*NOPASSWD:\s*ALL\)/\1/g' | EDITOR='sed -f- -i' visudo

# install a display server
$PACMAN xorg-server xorg-xinit xclip xorg-xrandr xorg-xsetroot xorg-xset

# install a display manager
$PACMAN lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
systemctl enable lightdm

$PACMAN bspwm sxhkd picom rofi alacritty polybar rofi feh picom dunst

# setup networking
$PACMAN networkmanager network-manager-applet wpa_supplicant iwd
systemctl enable NetworkManager

# setup audio
$PACMAN pipewire pipewire-alsa pipewire-pulse pipewire-jack alsa-utils wireplumber
systemctl enable --user pipewire pipewire-pulse wireplumber

# other utilities
$PACMAN docker firefox-developer-edition noto-fonts man-db man-pages

# give all users permission to execute the scripts
chmod a+rwx "$DIR"/*.sh
su -c "$DIR/03-user-setup.sh" $NEW_USER
