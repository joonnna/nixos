{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    videoDrivers = [ "nvidia" ];

    exportConfiguration = true; # link /usr/share/X11/ properly
    layout = "us,no";
    xkbOptions = "grp:alt_space_toggle";


    displayManager = {
      defaultSession = "none+i3";
    };

    libinput = {
      enable = true;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
      ];
    };
  };
}
