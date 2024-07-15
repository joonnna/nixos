{ home-manager, ... }:
{
  imports = [
    home-manager.nixosModule
  ];

  networking.hostName = "jon-work-desktop";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";

  home-manager.users.jon = { pkgs, lib, ... }: {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = [
          ",prefferred, auto,1.6"
          "Unknown-1,disable"
        ];
      };
    };
  };
}
