#!/usr/bin/env sh

### MANUAL STEPS ###
## find the disk to install to (list all disks with `fdisk -l` or `lsblk`)
## do the partitioning, etc.

## format them appropriately
# `mkfs.fat -F32 /dev/sda1` for EFI
# `mkfs.ext4 /dev/sdX1` # for root, home
# similarly for swap partitions,
# `mkswap /dev/sdX2`
# `swapon /dev/sdX2`

## Set the variables in config.sh

