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


