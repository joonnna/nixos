{ pkgs, ... }:
{
  services.displayManager = {
    defaultSession = "none+i3";
  };

  services.xserver =
    {
      enable = true;
      desktopManager = {
        xterm.enable = false;
      };

      exportConfiguration = true; # link /usr/share/X11/ properly

      xkb = {
        layout = "us,no";
        options = "grp:alt_space_toggle";
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          i3lock
        ];
      };
    };
}
