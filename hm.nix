{ config, lib, pkgs, nixpkgs, home-manager, ... }:

{
  imports = [
    home-manager.nixosModule
  ];
  home-manager.users.jon = { pkgs, lib, ... }: {
    imports = [
      ./hm/i3.nix
      ./hm/nvim/nvim.nix
      ./hm/git.nix
      ./hm/alacritty.nix
      ./hm/fish.nix
      ./hm/starship.nix
      ./hm/gh.nix
    ];
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    home.stateVersion = config.system.stateVersion;
    home.sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "alacritty";
      SHELL = "fish";
      NIX_PATH = "/etc/nix/path";
    };

    fonts.fontconfig.enable = true;

    # need for vivaldi (installed on user level)
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
      playerctl
      flameshot
      gcc
      docker
      docker-compose
      vivaldi
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
      # sqlx-cli
      postgresql
      unzip
      zip
      libreoffice
      terraform
      heaptrack
      chrysalis
      coreutils
      qmk
      _1password-gui
      killall
      usbutils
      jdk17
      openapi-generator-cli
      autorandr
      brightnessctl
      linuxKernel.packages.linux_6_5.perf
      yubikey-manager-qt

      # cargo-subcommands
      cargo-expand
      ttyper

      # Rust-based linux command replacements
      eza
      du-dust
      tealdeer
      dysk
      procs
      loc
      bottom
      ripgrep

      # Language servers
      sumneko-lua-language-server
      deno
      rnix-lsp
      rust-analyzer
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.yaml-language-server
      nodePackages.bash-language-server
      nodePackages.sql-formatter
      nodePackages.pyright
      nodePackages.prettier
      taplo-lsp
      terraform-ls
      # For bash language server
      shellcheck
    ];


    home.file."workspace/.envrc".text = ''
      use flake
    '';

    home.file.".git-credentials".text = ''
      https://jon-foss-mikalsen:0ebaa8eecc59492436e8012fe38fce24e4961518@dl.cloudsmith.io
    '';

    # 1password ssh keys
    xdg.configFile."ssh/config".text = ''
      Host *
      IdentityAgent ~/.1password/agent.sock
    '';


    # Private registries definitions
    xdg.configFile."cargo/config".text = ''
      [registries]
      orcalabs-orcastrator = { index = "https://dl.cloudsmith.io/basic/orcalabs/orcastrator/cargo/index.git" }
      [build]
      target-dir = "/home/jon/rust-target"
    '';

    # Credentials to publish to private registries
    xdg.configFile."cargo/credentials".text = ''
      [registries.orcalabs-orcastrator]
      token="0ebaa8eecc59492436e8012fe38fce24e4961518"
    '';
  };
}



