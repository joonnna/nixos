{ config, home-manager, ... }:
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
      ./hm/hyperland.nix
      ./hm/bottom.nix
      ./hm/bemenu.nix
      ./hm/zoxide.nix
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

    home.packages = with pkgs;
      [
        (nerdfonts.override {
          fonts = [ "Iosevka" "JetBrainsMono" "FiraCode" "IosevkaTerm" "0xProto" ];
        })
        playerctl
        flameshot
        gcc
        docker
        docker-compose
        vivaldi
        fzf
        alacritty
        wl-clipboard
        fd
        neofetch
        tree-sitter
        nodejs
        dbeaver-bin
        k9s
        azure-cli
        kubectl
        postgresql
        unzip
        zip
        libreoffice
        terraform
        heaptrack
        chrysalis
        coreutils
        qmk
        killall
        usbutils
        jdk17
        openapi-generator-cli
        autorandr
        brightnessctl
        linuxKernel.packages.linux_6_8.perf
        cmake
        wget
        gnumake
        tcpdump
        wireshark
        ttyper
        nvtopPackages.full
        auth0-cli
        sqlx-cli
        hyprpaper
        gdb
        nix-search-cli

        # tofi currently fails to open 1password which is installed on system lvl
        # due to not searching all xdg_data_dir paths for desktop entries.
        # For now using bemenu (see bemenu.nix)
        # tofi

        # Rust-based linux command replacements
        eza
        bat
        du-dust
        tealdeer
        dysk
        procs
        loc
        ripgrep

        xdg-utils
        xdg-desktop-portal
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk

        # nix related commands
        nix-tree

        # https://wiki.hyprland.org/Useful-Utilities/Must-have/
        qt6.qtwayland

        # Language servers
        sumneko-lua-language-server
        deno
        nil
        # formatter for nil
        nixpkgs-fmt
        rust-analyzer
        nodePackages.dockerfile-language-server-nodejs
        nodePackages.yaml-language-server
        # nodePackages.bash-language-server
        nodePackages.sql-formatter
        # nodePackages.pyright
        nodePackages.prettier
        taplo-lsp
        terraform-ls
        # For bash language server
        shellcheck
      ];

    home.file."workspace/.envrc".text = ''
      use nix
    '';

    home.file."workspace/rust-toolchain.toml".text = ''
      [toolchain]
      profile = "default"
      channel = "stable"
      components = ["rust-analyzer"]
    '';

    home.file."vivaldi-css/header.css".text = ''
      #header {
          display: none;
      }
    '';

    # home.file."workspace/default.nix".text = builtins.readFile ./shells/rust_workspace.nix;

    xdg.configFile."cargo/config.toml".text = ''
      # https://github.com/rust-lang/cargo/tree/master/credential/cargo-credential-1password
      [registry]
      global-credential-providers = ["cargo-credential-1password --account my.1password.com"]

      # https://help.cloudsmith.io/docs/cargo-registry#cargo--v174-http-sparse-registry
      [registries.orcalabs-orcastrator]
      index = "sparse+https://cargo.cloudsmith.io/orcalabs/orcastrator/"

      [build]
      target-dir = "/home/jon/workspace/rust-target"
    '';

    # 1password ssh keys
    xdg.configFile."ssh/config".text = ''
      Host *
      IdentityAgent ~/.1password/agent.sock
    '';

    xdg.configFile."op/plugins.sh".text = ''
      export OP_PLUGIN_ALIASES_SOURCED=1
      alias cargo="op plugin run -- cargo"
      alias gh="op plugin run -- gh"
    '';

    xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload = ~/nixos/wall.jpg
      wallpaper = ,~/nixos/wall.jpg
      ipc = off
    '';
  };
}
