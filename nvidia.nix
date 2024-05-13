{
  services.xserver.videoDrivers = [ "nvidia" ];
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
}
