{ pkgs ? import <nixpkgs> {
    inherit system;
  }
, system ? builtins.currentSystem
}:

let
  nodePackages = import ./def.nix {
    inherit pkgs system;
  };
in
nodePackages // {
  sql-language-server = nodePackages.sql-language-server.override {
    buildInputs = [ pkgs.pkg-config ];
  };
}
