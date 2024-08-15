{ config, home-manager, ... }:
{
  imports = [
    home-manager.nixosModule
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  virtualisation.docker.enableNvidia = true;

  home-manager.users.jon = { pkgs, lib, ... }: {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        env = [
          "LIBVA_DRIVER_NAME,nvidia"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "NVD_BACKEND,direct"
        ];
      };
    };
  };
}
