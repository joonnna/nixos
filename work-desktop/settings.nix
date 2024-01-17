{ config, pkgs, ... }:

{
  networking.hostName = "jon-work-desktop";

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";

  services.xserver.displayManager.setupCommands = ''
    ${pkgs.autorandr}/bin/autorandr horizontal
  '';
}
