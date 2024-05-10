{ pkgs, nixpkgs, ... }:

{
  imports =
    [
      ./hm.nix
      ./gui.nix
      ./sound.nix
      ./udev.nix
      ./vagrant.nix
      ./ssh.nix
    ];

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


  # Need for nvidia (installed on system level)
  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.enableNvidia = true;

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
    ];
  };

  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [
    # siji
    # unifont
    # font-awesome
    openmoji-color
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
