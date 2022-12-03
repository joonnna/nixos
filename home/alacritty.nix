{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
  };

  # Want to configure alacritty using only nix, but having an issue
  # where the settings provided does not generate an alacritty.yml
  # under the .config directory, fallback for now to a raw yml file.
  # Relevant issue: https://github.com/nix-community/home-manager/issues/2620
  xdg.configFile."alacritty.yml" = {
    source = ./alacritty.yml;
  };
}
