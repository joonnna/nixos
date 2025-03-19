{ config, home-manager, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = true;
  };
}
