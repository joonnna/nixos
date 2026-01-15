{ config, home-manager, ... }:
{


  imports = [
    home-manager.nixosModules.home-manager
  ];

  systemd.tmpfiles.settings."1password_config"."/home/jon/.config/op" = {
    d = {
      group = "jon";
      mode = "0700";
      user = "jon";
    };
  };

  home-manager.users.jon = { pkgs, lib, ... }: {
    imports = [
      ./hm/i3.nix
      ./hm/nvim/nvim.nix
      ./hm/git.nix
      ./hm/alacritty.nix
      ./hm/fish.nix
      ./hm/starship.nix
      ./hm/gh.nix
      ./hm/bottom.nix
      ./hm/bemenu.nix
      ./hm/rainfrog.nix
      ./hm/nushell.nix
      ./hm/firefox.nix
      ./hm/fzf.nix
    ];
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    home.stateVersion = config.system.stateVersion;
    home.sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "alacritty";
      SHELL = "fish";
      NIX_PATH = "/etc/nix/path";
      BROWSER = "vivaldi";
    };

    fonts.fontconfig.enable = true;

    # need for vivaldi (installed on user level)
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs;
      [
        # Clipboard support
        xclip
        # To completley rebuild the font cache run `fc-cache -rv`
        # Might also need to manually clear `~/.cache/fontconfig`
        # See issue for details: https://github.com/nix-community/home-manager/issues/6160
        nerd-fonts.iosevka

        playerctl
        flameshot
        gcc
        docker
        docker-compose
        vivaldi
        alacritty
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
        coreutils
        qmk
        killall
        usbutils
        jdk17
        openapi-generator-cli
        autorandr
        brightnessctl
        # linuxKernel.packages.linux_6_14.perf
        cmake
        wget
        gnumake
        nvtopPackages.full
        auth0-cli
        sqlx-cli
        gdb
        nix-search-cli
        ttyper
        hyperfine
        pgcopydb
        brave

        slack
        bluetui
        impala

        nushellPlugins.polars

        # GUI to sanity check audio status
        pavucontrol

        # egl-wayland

        vial

        carapace

        # tofi currently fails to open 1password which is installed on system lvl
        # due to not searching all xdg_data_dir paths for desktop entries.
        # For now using bemenu (see bemenu.nix)
        # tofi

        # Rust-based linux command replacements
        eza
        bat
        dust
        tealdeer
        dysk
        procs
        tokei
        ripgrep
        csvlens
        difftastic
        ouch
        xh
        cargo-udeps

        rofi

        # Nix related commands
        nix-tree

        nodePackages.prettier

        ### Language servers

        # Javascript runtime and lsp written in rust, not compatible formatting with everyone not using deno (see lsp.lua for all filetypes deno provides lsp/formatting for)
        deno

        # Javascript hell (use this if we want to be compliant with everyone not using deno)
        # https://github.com/neovim/nvim-lspconfig/pull/3232#issuecomment-2331025714
        nodePackages.typescript-language-server


        jq
        lua-language-server

        tree

        # Nix
        nil
        # formatter for nil
        nixpkgs-fmt

        nodePackages.dockerfile-language-server-nodejs
        nodePackages.yaml-language-server
        nodePackages.bash-language-server
        nodePackages.sql-formatter

        # Python formatter used by ty
        ruff
        # Python lsp
        pyright

        # TOML
        taplo
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
      channel = "1.91.1"
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
      global-credential-providers = ["cargo-credential-1password --account orcalabs.1password.com"]

      # https://help.cloudsmith.io/docs/cargo-registry#cargo--v174-http-sparse-registry
      [registries.orcalabs-orcastrator]
      index = "sparse+https://cargo.cloudsmith.io/orcalabs/orcastrator/"

      [build]
      target-dir = "/home/jon/workspace/rust-target"
    '';

    # 1password ssh keys
    home.file.".ssh/config".text = ''
      Host *
      IdentityAgent ~/.1password/agent.sock
    '';

    xdg.configFile."op/plugins.sh".text = ''
      export OP_PLUGIN_ALIASES_SOURCED=1
      alias cargo="op plugin run -- cargo"
      alias gh="op plugin run -- gh"
    '';
  };
}
