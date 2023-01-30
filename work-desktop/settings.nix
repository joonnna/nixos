{ config, pkgs, ... }:

{
  networking.hostName = "jon-work-desktop";

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;

  services.xserver.displayManager.setupCommands = ''
    LEFT='DP-2'
    CENTER='DP-0'
    RIGHT='DP-6'
    ${pkgs.xorg.xrandr}/bin/xrandr --output $CENTER --primary --output $RIGHT --right-of $CENTER --output $LEFT --left-of $CENTER
  '';
}
