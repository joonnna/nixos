{ config, pkgs, ... }:

{
  networking.hostName = "jon-work-laptop";
  services.xserver.videoDrivers = [ "intel" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
}
