{ home-manager, ... }:
{
  networking.hostName = "jon-work-desktop";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";


  imports = [
    home-manager.nixosModules.home-manager
  ];

  home-manager.users.jon = { pkgs, lib, ... }: {
    xsession.windowManager.i3 = {
      extraConfig = ''
        workspace 1 output DP-0
        workspace 2 output DP-2
        workspace 3 output DP-4
      '';
    };
  };
}

