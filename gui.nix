{ pkgs, ... }:

{

  hardware.nvidia = {
    modesetting.enable = true;
    #   package = config.boot.kernelPackages.nvidiaPackages.production;
    nvidiaSettings = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    # Need for tensorflow see (https://nixos.wiki/wiki/Tensorflow)
    setLdLibraryPath = true;
  };

  # wayland.windowManager.hyprland.enable = true;
  programs.hyprland.enable = true;
  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # services.displayManager = {
  #   defaultSession = "none+Hyprland";
  # };
  # services.xserver =
  #   {
  #     enable = true;
  #     desktopManager = {
  #       xterm.enable = false;
  #     };
  #     videoDrivers = [ "nvidia" ];

  #     exportConfiguration = true; # link /usr/share/X11/ properly

  #     xkb = {
  #       layout = "us,no";
  #       options = "grp:alt_space_toggle";
  #     };

  #     libinput = {
  #       enable = true;
  #     };

  #     windowManager.i3 = {
  #       enable = true;
  #       extraPackages = with pkgs; [
  #         dmenu
  #         # i3status
  #         i3lock
  #       ];
  #     };
  #   };
}
