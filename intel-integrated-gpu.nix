{ pkgs, ... }:
{
  services.xserver.videoDrivers = [ "intel" ];

  # OpenGL
  hardware.graphics = {
    extraPackages = with pkgs; [ intel-media-sdk ];
  };
}
