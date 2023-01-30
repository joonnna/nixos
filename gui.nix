{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    videoDrivers = [ "nvidia" ];


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
