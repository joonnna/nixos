{ config, lib, pkgs, nixpkgs, ... }:

let customNodePackages = pkgs.callPackage ./custom_node_packages { };
in
{
  imports =
    [
      ./hm.nix
      ./gui.nix
      ./sound.nix
      # ./custom_node_packages/override.nix
    ];

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Oslo";

  nix.nixPath = [ "/etc/nix/path" ];
  nix.registry.nixpkgs.flake = nixpkgs;
  environment.etc."nix/path/nixpkgs".source = nixpkgs;

  services.gnome.gnome-keyring.enable = true;
  programs.ssh.startAgent = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
      neofetch
      tree-sitter
      nodejs
      dbeaver
      k9s
      azure-cli
      kubectl
      sqlx-cli
      postgresql
      unzip
      libreoffice
      node2nix
      customNodePackages.sql-language-server

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
      nodePackages.sql-formatter

      # TODO: install this declaratively
      # nodePackages.sql-language-server

      # For bash language server
      shellcheck
    ];
    shell = pkgs.fish;
  };

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = "22.05";
}

