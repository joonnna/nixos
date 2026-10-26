{
  networking.hostName = "jon";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };

  systemd.tmpfiles.settings."1password_config"."/home/jon/.config/op" = {
    d = {
      group = "jon";
      mode = "0700";
      user = "jon";
    };
  };
}
