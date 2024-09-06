{ home-manager, ... }:
{
  imports = [
    home-manager.nixosModule
  ];

  networking.hostName = "jon-work-laptop";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";

  home-manager.users.jon = { pkgs, lib, ... }: {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = [
          ",prefferred, auto,1"
          "Unknown-1,disable"
        ];
      };
    };
  };
}
