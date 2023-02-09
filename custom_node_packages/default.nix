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
  shell = nodePackages.shell.override {
    buildInputs = [
      pkgs.pkg-config
      pkgs.nodePackages.node-pre-gyp
      pkgs.nodePackages.node-gyp-build
      pkgs.openssl
      pkgs.vips
      pkgs.glib
    ];
  };
  sql-language-server = nodePackages.sql-language-server.override
    {
      buildInputs = [
        pkgs.pkg-config
        pkgs.nodePackages.node-pre-gyp
        pkgs.nodePackages.node-gyp-build
        pkgs.openssl
        pkgs.vips
        pkgs.glib
      ];
      # https://github.com/svanderburg/node2nix/issues/275#issuecomment-994007054
      # preRebuild = ''
      #   sed -i -e "s|#!/usr/bin/env node|#! ${pkgs.nodejs}/bin/node|" node_modules/node-gyp-build/bin.js
      # '';
    };
}
