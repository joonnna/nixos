{ ... }:
{

  networking.hostName = "jon-work-laptop";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
}
