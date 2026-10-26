mkfs.ext4 -L nixos "$1"
mkfs.fat -F 32 -n boot "$2"
mount "$1" /mnt
mkdir -p /mnt/boot
mount -o umask=077 "$2" /mnt/boot
nixos-generate-config --root /mnt
vim /mnt/etc/nixos/configuration.nix
