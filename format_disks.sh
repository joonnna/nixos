mkfs.ext4 -L nixos /dev/"$1"
mkfs.fat -F 32 -n boot /dev/"$2"
mount /dev/"$1" /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/"$2" /mnt/boot
nixos-generate-config --root /mnt
cat > /mnt/etc/nixos/configuration.nix <<EOF
{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Choose your boot loader (e.g., systemd-boot for UEFI or grub for BIOS)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "$3"; # Define your hostname
  # networking.networkmanager.enable = true; # E.g., enable wireless support

  # Set your time zone.
  time.timeZone = "UTC";

  # Select internationalization properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Define a user account. (You'll need to set a password with 'passwd')
  users.users.$4 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  # This value determines the NixOS release from which the default
  # state is commented or set. Read the wiki before changing.
  system.stateVersion = "26.11"; # Matches your install version
}
EOF
nixos-enter --root /mnt -c \'"passwd $4"\'
