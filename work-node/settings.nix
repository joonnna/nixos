{
  networking.hostName = "work-node";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };

  systemd.tmpfiles.settings."1password_config"."/home/orca/.config/op" = {
    d = {
      group = "orca";
      mode = "0700";
      user = "orca";
    };
  };
}

