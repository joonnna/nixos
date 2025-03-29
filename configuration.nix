{ pkgs, nixpkgs, ... }:

{
  # TODO:
  #  - declarative browser setup
  #  - set file permission for '~/.config/op' dir to 600 declarative
  #  - declarative op plugin setup config (links between cargo plugin wrapper and which credential to use
  #  - figure out build time issue

  imports =
    [
      ./hm.nix
      ./gui.nix
      ./sound.nix
      ./udev.nix
      ./ssh.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Oslo";

  nix.nixPath = [ "/etc/nix/path" ];
  nix.registry.nixpkgs.flake = nixpkgs;
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  nix.settings.experimental-features = "nix-command flakes";
  environment.etc."nix/path/nixpkgs".source = nixpkgs;

  # See: https://discourse.nixos.org/t/slow-build-at-building-man-cache/52365
  documentation.man.generateCaches = false;

  # Need for nvidia (installed on system level)
  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;

  # Home-manager can only configure fish, but not set it as default login shell
  # as that requires root permissions
  programs.fish.enable = true;
  # See comment above why this is required
  # Sets the shell of all users to fish
  users.defaultUserShell = pkgs.fish;
  users.users.jon = {
    isNormalUser = true;
    initialPassword = "pw123";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "qemu-libvirtd"
      "libvirtd"
      "storage"
      "onepassword-cli"
      "onepassword"
    ];
  };

  environment.systemPackages = with pkgs; [
    polkit_gnome
    man-pages
    man-pages-posix
    xdg-utils
  ];

  documentation.dev.enable = true;

  programs._1password = {
    enable = true;
  };
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "jon" ];
  };


  # OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };


  # https://nixos.wiki/wiki/1Password
  # Allows the desktop app to unlock 1password in vivaldi
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        vivaldi-bin
      '';
      mode = "0755";
    };
  };

  # Need for 1password system authentication support
  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    # siji
    # unifont
    # font-awesome
    openmoji-color
    nerd-fonts.iosevka
    # terminus
  ];

  # auto mount usb sticks
  services.udisks2.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8080 ];
  };

  security.pam.loginLimits = [
    { domain = "*"; type = "-"; item = "nofile"; value = "unlimited"; }
    { domain = "*"; type = "-"; item = "fsize"; value = "unlimited"; }
  ];


  # Does nothing, only metadata from initial config generation during installation
  system.stateVersion = "22.05";
}
