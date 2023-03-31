{ config, lib, pkgs, nixpkgs, home-manager, ... }:

{
  imports = [
    home-manager.nixosModule
  ];
  home-manager.useGlobalPkgs = true;
  home-manager.users.jon = { pkgs, lib, ... }: {
    imports = [
      ./hm/i3.nix
      ./hm/nvim/nvim.nix
      ./hm/git.nix
      ./hm/alacritty.nix
      ./hm/fish.nix
      ./hm/starship.nix
    ];
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    programs.fish.enable = true;

    home.stateVersion = config.system.stateVersion;
    home.sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "alacritty";
      SHELL = "fish";
      NIX_PATH = "/etc/nix/path";
    };

    fonts.fontconfig.enable = true;

    home.packages = [
      (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
    ];

    # home.file."workspace/flake.nix".text = ''
    #   {
    #     description = "rust setup overlay";

    #     inputs = {
    #       rust-overlay.url = "github:oxalica/rust-overlay";
    #       flake-utils.url = "github:numtide/flake-utils";
    #     };

    #     outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    #       flake-utils.lib.eachDefaultSystem (system:
    #         let
    #           overlays = [ (import rust-overlay) ];
    #           pkgs = import nixpkgs {
    #             inherit system overlays;
    #           };
    #         in
    #         with pkgs;
    #         {
    #           devShells.default = mkShell {
    #             buildInputs = [
    #               openssl
    #               pkg-config
    #               protobuf
    #               rust-bin.stable."1.68.0".default
    #             ];
    #           };
    #         }
    #       );
    #   }
    # '';
    # home.file."workspace/.envrc".text = ''
    #   use flake
    # '';

    home.file.".git-credentials".text = ''
      https://jon-foss-mikalsen:0ebaa8eecc59492436e8012fe38fce24e4961518@dl.cloudsmith.io
    '';

    # Private registries definitions
    xdg.configFile."cargo/config".text = ''
      [registries]
      orcalabs-orcastrator = { index = "https://dl.cloudsmith.io/basic/orcalabs/orcastrator/cargo/index.git" }
    '';

    # Credentials to publish to private registries
    xdg.configFile."cargo/credentials".text = ''
      [registries.orcalabs-orcastrator]
      token="0ebaa8eecc59492436e8012fe38fce24e4961518"
    '';

  };
}


