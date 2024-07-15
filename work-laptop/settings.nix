{ home-manager, pkgs, ... }:
{
  imports = [
    home-manager.nixosModule
  ];

  networking.hostName = "jon-work-laptop";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";

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
        monitor = [
          ",prefferred, auto,1"
          "Unknown-1,disable"
        ];
      };
    };
  };
}
