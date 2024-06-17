{ home-manager, ... }:
{
  imports = [
    home-manager.nixosModule
  ];

  home-manager.users.jon = { pkgs, lib, ... }: {
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          ",prefferred, auto,1"
          "Unknown-1,disable"
        ];
      };
    };
  };
}

