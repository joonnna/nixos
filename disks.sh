parted /dev/"$1" -- mklabel gpt
parted /dev/"$1" -- mkpart root ext4 512MB 100%
parted /dev/"$1" -- mkpart ESP fat32 1MB 512MB
parted /dev/"$1" -- set 2 esp on
