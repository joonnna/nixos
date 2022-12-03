{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.jon = { pkgs, lib, ... }: {
    imports = [
      ./home/i3.nix
      ./home/nvim/nvim.nix
      ./home/git.nix
      ./home/alacritty.nix
      ./home/fish.nix
    ];
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    programs.fish.enable = true;

    home.stateVersion = config.system.stateVersion;
    home.sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "alacritty";
      SHELL = "fish";
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
