{ config, lib, pkgs, nixpkgs, ... }:

{
  imports =
    [
      ./hm.nix
      ./gui.nix
      ./sound.nix
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
      zip
      libreoffice
      terraform
      heaptrack
      chrysalis

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
      taplo-lsp
      terraform-ls
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

  services.udev.packages = [
    (pkgs.writeTextFile
      {
        name = "moonlander_udev";
        text = ''
          # Rules for Oryx web flashing and live training
          KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
          KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

          # Legacy rules for live training over webusb (Not needed for firmware v21+)
            # Rule for all ZSA keyboards
            SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
            # Rule for the Moonlander
            SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
            # Rule for the Ergodox EZ
            SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
            # Rule for the Planck EZ
            SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

          # Wally Flashing rules for the Ergodox EZ
          ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
          ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
          SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
          KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

          # Wally Flashing rules for the Moonlander and Planck EZ
          SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11",     MODE:="0666",     SYMLINK+="stm32_dfu"
        '';
        destination = "/etc/udev/rules.d/50-zsa.rules";
      })
    (pkgs.writeTextFile
      {
        name = "keyboardio_udev";
        text = ''
          ## SOURCE: https://github.com/keyboardio/Chrysalis/pull/570/files
          ## This file sets up a few things for selected Kaleidoscope-powered keyboards:
          ## - We first symlink the device to a more friendly name, based on the product
          ##   name.
          ## - We then ask ModemManager to ignore the serial ports on the device, and not
          ##   consider them a candidate.
          ## - We also tell systemd to grant access to the device (via ACLs) to the user
          ##   at-seat.
          ##
          ## For more information about the access part, see the following resources:
          ##  - https://github.com/systemd/systemd/issues/4288
          ##  - https://www.freedesktop.org/software/systemd/man/sd-login.html

          SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2300", SYMLINK+="model01", ENV{ID_MM_DEVICE_IGNORE}:="1", ENV{ID_MM_CANDIDATE}:="0", TAG+="uaccess", TAG+="seat"
          SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2301", SYMLINK+="model01", ENV{ID_MM_DEVICE_IGNORE}:="1", ENV{ID_MM_CANDIDATE}:="0", TAG+="uaccess", TAG+="seat"
          SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2302", SYMLINK+="Atreus2", ENV{ID_MM_DEVICE_IGNORE}:="1", ENV{ID_MM_CANDIDATE}:="0", TAG+="uaccess", TAG+="seat"
          SUBSYSTEMS=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="2303", SYMLINK+="Atreus2", ENV{ID_MM_DEVICE_IGNORE}:="1", ENV{ID_MM_CANDIDATE}:="0", TAG+="uaccess", TAG+="seat"
        '';
        destination = "/etc/udev/rules.d/60-kaleidoscope.rules";
      })
  ];
}

