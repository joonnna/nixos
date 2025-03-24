{ pkgs, ... }:
{
  services.displayManager = {
    defaultSession = "none+i3";
  };

  # services.libinput = {
  #   enable = true;
  # };
  #
  services.xserver =
    {
      enable = true;
      desktopManager = {
        xterm.enable = false;
      };

      videoDrivers = [ "nvidia" ];

      exportConfiguration = true; # link /usr/share/X11/ properly

      xkb = {
        layout = "us,no";
        options = "grp:alt_space_toggle";
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          # dmenu
          i3status
          # i3lock
        ];
      };
    };
}
