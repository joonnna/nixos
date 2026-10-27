{ home-manager, ... }:
{
  networking.hostName = "jon-work-desktop";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";

  imports = [
    home-manager.nixosModules.home-manager
  ];

  systemd.tmpfiles.settings."1password_config"."/home/jon/.config/op" = {
    d = {
      group = "jon";
      mode = "0700";
      user = "jon";
    };
  };

  fileSystems."/home/jon/ignition" =
    {
      device = "/dev/sda1";
      fsType = "exfat";
      options = [ "rw" "defaults" "uid=1000" "gid=1000" "umask=000" ];
    };


  home-manager.users.jon = { pkgs, lib, ... }: {
    home.file.".xprofile".text = ''
      autorandr horizontal
      xrandr --output DP-0 --primary
    '';
    xsession.windowManager.i3 = {
      extraConfig = ''
        workspace 1 output DP-0
        workspace 2 output DP-2
        workspace 3 output DP-6
      '';
    };
  };
}

