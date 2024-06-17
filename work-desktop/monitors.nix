{ home-manager, ... }:
{
  imports = [
    home-manager.nixosModule
  ];

  home-manager.users.jon = { pkgs, lib, ... }: {
    wayland.windowManager.hyprland = {
      settings = {
        monitor = [
          ",prefferred, auto,1.6"
          "Unknown-1,disable"
        ];
      };
    };
  };
}

