# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./home.nix
      ./gui.nix
      ./sound.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";

  networking.hostName = "jon";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Oslo";

  services.gnome3.gnome-keyring.enable = true;
  programs.ssh.startAgent = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  programs.fish.enable = true;
  nixpkgs.config.allowUnfree = true;

  users.users.jon = {
    isNormalUser = true;
    initialPassword = "pw123";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      flameshot
      neovim
      git
      gh
      rustup
      docker
      docker-compose
      vivaldi
      fish
      fzf
      alacritty
      xclip
      fd

      # Rust-based linux command replacements
      exa
      du-dust
      tealdeer
      lfs
      procs
      loc
      bottom

      # Language servers
      sumneko-lua-language-server
      deno
      rnix-lsp
      rust-analyzer
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.yaml-language-server
      nodePackages.bash-language-server
      # For bash language server
      shellcheck
    ];
    shell = pkgs.fish;
  };

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  system.stateVersion = "22.05";
}

