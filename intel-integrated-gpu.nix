{ home-manager, pkgs, ... }:
{
  imports = [
    home-manager.nixosModule
  ];

  services.xserver.videoDrivers = [ "intel" ];

  # OpenGL
  hardware.graphics = {
    extraPackages = with pkgs; [ intel-media-sdk ];
  };

  home-manager.users.jon = { pkgs, lib, ... }: {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        env = [
          "LIBVA_DRIVER_NAME,iHD"
        ];
      };
    };
  };
}
