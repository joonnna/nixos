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
    open = true;
  };

  home-manager.users.jon = { pkgs, lib, ... }: {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        env = [
          "LIBVA_DRIVER_NAME,nvidia"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "NVD_BACKEND,direct"
          "__NV_PRIME_RENDER_OFFLOAD,1"
          # "DRI_PRIME,pci-0000_01_00_0"
          # "__VK_LAYER_NV_optimus,NVIDIA_only"
        ];
      };
    };
  };
}
