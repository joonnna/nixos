{ config, lib, pkgs, ... }:

{
  programs.starship.enable = true;
  programs.starship.settings = {
    git_branch = {
      symbol = " ";
    };
  };
}
