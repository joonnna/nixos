{ pkgs, ... }:
{
  services.xserver.videoDrivers = [ "modesetting" ];

  # OpenGL
  hardware.graphics = {
    extraPackages = with pkgs; [ intel-media-sdk ];
  };
}
