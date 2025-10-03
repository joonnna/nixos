{ pkgs, ... }:
{
  services.xserver.videoDrivers = [ "modesetting" ];

  # OpenGL
  hardware.graphics = {
    enable = true;
  };
}
