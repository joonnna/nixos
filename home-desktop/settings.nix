{ home-manager, ... }:
{
  imports = [
    home-manager.nixosModule
  ];

  networking.hostName = "jon";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };

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
