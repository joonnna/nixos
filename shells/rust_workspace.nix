{ pkgs ? (import <nixpkgs> { config.allowUnfree = true; }) }:
let
  overrides = (builtins.fromTOML (builtins.readFile ./rust-toolchain.toml));
  libPath = with pkgs; lib.makeLibraryPath [
    # load external libraries that you need in your rust project here
    cudatoolkit
    cudaPackages.libcublas
    cudaPackages.cudnn
    cudaPackages.libcurand
    cudaPackages.libcufft
    # glibc.static
  ];
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # glibc.static
    ffmpeg
    clang
    rustup
    pkg-config
    yasm
    # openssl, ffmpeg, and opencv4 are found through pkg-config, and are not in LD_LIBRARY_PATH
    # The final pkg-config search path is defined by PKG_CONFIG_PATH_FOR_TARGET
    (opencv4.override { enableUnfree = true; enableCuda = true; })
    openssl
    cudatoolkit
    cudaPackages.libcublas
    cudaPackages.cudnn
    cudaPackages.libcurand
    cudaPackages.libcufft
    # cudaPackages.

    # python
    python310
    python310Packages.pip
  ];
  APP_ENVIRONMENT = "local";
  RUSTC_VERSION = overrides.toolchain.channel;
  # https://github.com/rust-lang/rust-bindgen#environment-variables
  LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
  shellHook = ''
    export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
    export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
  '';
  LD_LIBRARY_PATH = libPath;
}
