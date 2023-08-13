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

      # cargo-subcommands
      cargo-expand
      ttyper

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


    home.file."workspace/flake.nix".text = ''
      {
        description = "rust setup overlay";

        inputs = {
          rust-overlay.url = "github:oxalica/rust-overlay";
          flake-utils.url = "github:numtide/flake-utils";
        };

        outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
          flake-utils.lib.eachDefaultSystem (system:
            let
              overlays = [ (import rust-overlay) ];
              pkgs = import nixpkgs {
                inherit system overlays;
              };
            in
            with pkgs;
            {
              devShells.default = mkShell {
                buildInputs = [
                  openssl
                  pkg-config
                  protobuf
                  rust-bin.stable.latest.default
                ];
              };
            }
          );
      }
    '';
    home.file."workspace/.envrc".text = ''
      use flake
    '';

    home.file.".git-credentials".text = ''
      https://jon-foss-mikalsen:0ebaa8eecc59492436e8012fe38fce24e4961518@dl.cloudsmith.io
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


