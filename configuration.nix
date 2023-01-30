{ config, lib, pkgs, nixpkgs, ... }:

{
  imports =
    [
      ./hm.nix
      ./gui.nix
      ./sound.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Oslo";

  nix.nixPath = [ "/etc/nix/path" ];
  nix.registry.nixpkgs.flake = nixpkgs;
  environment.etc."nix/path/nixpkgs".source = nixpkgs;

  services.gnome.gnome-keyring.enable = true;
  programs.ssh.startAgent = true;

  programs.fish.enable = true;
  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;

  users.users.jon = {
    isNormalUser = true;
    initialPassword = "pw123";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = with pkgs; [
      flameshot
      neovim
      git
      gh
      gcc
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

      neofetch
      tree-sitter
      nodejs

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

      dbeaver
    ];
    shell = pkgs.fish;
  };

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  system.stateVersion = "22.05";
}

