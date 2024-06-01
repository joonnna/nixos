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
    zlib
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
    # cudaPackages.cudnn
    cudaPackages.libcurand
    cudaPackages.libcufft
    # linuxPackages.nvidia_x11
    # cudaPackages.

    # python
    python310
    python310Packages.pip
  ];
  RUSTC_VERSION = overrides.toolchain.channel;
  # https://github.com/rust-lang/rust-bindgen#environment-variables
  LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
  LD_LIBRARY_PATH = libPath;
  shellHook = ''
    export LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib:$LD_LIBRARY_PATH;
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib/:$LD_LIBRARY_PATH;

    export ORT_DYLIB_PATH=/home/jon/workspace/onnxruntime-linux-x64-gpu-1.17.3/lib/libonnxruntime.so.1.17.3
    export APP_ENVIRONMENT=local;

    # export CUDA_HOME=${pkgs.cudatoolkit}

    export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
    export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
  '';
}
