{

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    # Need for tensorflow see (https://nixos.wiki/wiki/Tensorflow)
    setLdLibraryPath = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  programs.hyprland.enable = true;

  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
