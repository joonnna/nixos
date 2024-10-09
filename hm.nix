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
      ./hm/rainfrog.nix
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
          fonts = [ "Iosevka" ];
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
        linuxKernel.packages.linux_6_10.perf
        cmake
        wget
        gnumake
        nvtopPackages.full
        auth0-cli
        sqlx-cli
        hyprpaper
        gdb
        nix-search-cli
        hyprpicker
        ttyper
        nushell
        hyperfine

        pavucontrol

        egl-wayland

        lazygit
        lazydocker

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

        # Nix related commands
        nix-tree

        # https://wiki.hyprland.org/Useful-Utilities/Must-have/
        qt6.qtwayland

        # Javascrip hell
        nodePackages.prettier
        # https://github.com/neovim/nvim-lspconfig/pull/3232#issuecomment-2331025714
        nodePackages.typescript-language-server

        # Language servers
        sumneko-lua-language-server
        # Nix
        nil
        # formatter for nil
        nixpkgs-fmt
        rust-analyzer
        nodePackages.dockerfile-language-server-nodejs
        nodePackages.yaml-language-server
        nodePackages.bash-language-server
        nodePackages.sql-formatter
        pyright
        # TOML
        taplo-lsp
        terraform-ls
        # Bash language server dependency
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
