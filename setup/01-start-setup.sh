#!/usr/bin/env sh

set -eo pipefail

# store current list of env vars
ENVVARS="$(env)"

# load the config file, relative to this script
DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$DIR/config.sh"


# print all the env vars that were set
comm -1 -3 <(sort <<< "$ENVVARS") <(env | sort)

## press enter or wait 10 seconds to continue
## press any other key to abort
unset KEY
echo "Make sure all the variables above are correct, and if the partitions \
mentioned are formatted correctly."
read -t 10 -n 1 -p "Press ENTER or wait 10 seconds to continue. \
Press any other key to abort..." KEY

# if $KEY is empty or newline, continue
if [ -n "$KEY" ]; then
	echo -e "\n Aborting..."
	exit 1
fi


on_exit() {
	echo "Exiting, and unmounting partitions..."
	umount /mnt/boot/efi
	umount /mnt/home
	umount /mnt
}
trap on_exit EXIT

# mount the partitions
if [ -z "$PARTITION_ROOT" ]; then
	echo "PARTITION_ROOT not set, exiting..."
	exit 1
fi
mount $PARTITION_ROOT /mnt

# if partition is set, mount it
if [ -z "$PARTITION_EFI" ]; then
	echo "PARTITION_EFI not set, exiting..."
	exit 1
fi
mkdir -p /mnt/boot/efi
mount $PARTITION_EFI /mnt/boot/efi # EFI

mkdir -p /mnt/home # home
if [ -n "$PARTITION_HOME" ]; then
	mount $PARTITION_HOME /mnt/home # home
fi

if [ -n "$PARTITION_SWAP" ]; then
	swapon "$PARTITION_SWAP"
fi

set -x

# enables network time synchronization
timedatectl set-ntp true

# sync pacman repos
pacman -Syy

## install base packages to /mnt with pacstrap. If it's already installed, skip it.
## set a flag in /mnt/tmp/pacstrap_installed to indicate that it's already installed
if [ ! -f /mnt/tmp/pacstrap_installed ]; then
	pacstrap /mnt base linux linux-firmware
	touch /mnt/tmp/pacstrap_installed
fi

# generate fstab file
genfstab -U /mnt >>/mnt/etc/fstab

# chroot into the new system
cp -r "$DIR/../../" /mnt/
sudo arch-chroot /mnt "/dotfiles/setup/02-post-chroot.sh"
