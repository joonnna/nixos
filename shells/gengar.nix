{ pkgs ? (import <nixpkgs> { config.allowUnfree = true; }) }:
let
  python = pkgs.python310;
  pythonPackages = python.pkgs;
  libPath = with pkgs; lib.makeLibraryPath [
    # load external libraries that you need in your rust project here
    cudatoolkit
    cudaPackages.libcublas
    cudaPackages.cudnn
    cudaPackages.libcurand
    cudaPackages.libcufft
    zlib
    libGL
    glib
  ];
in
with pkgs; mkShell {
  packages = [
    pythonPackages.venvShellHook
  ];

  buildInputs = [
    (opencv4.override { enableUnfree = true; enableCuda = true; })
    openssl
    cudatoolkit
    cudaPackages.libcublas
    cudaPackages.cudnn
    cudaPackages.libcurand
    cudaPackages.libcufft
    protobuf
    ffmpeg
    clang
    rustup
    pkg-config
    yasm

    # zlib
    # libGL
    # glib
    #
    python310
    python310Packages.pip
  ];

  LD_LIBRARY_PATH = libPath;
  LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];

  shellHook = ''
    SOURCE_DATE_EPOCH=$(date +%s)
    VENV=.venv

    export LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib:$LD_LIBRARY_PATH;
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib/:$LD_LIBRARY_PATH;

    if test ! -d $VENV; then
      python -m venv $VENV
    fi

    source ./$VENV/bin/activate
    export PYTHONPATH=`pwd`/$VENV/${python.sitePackages}/:$PYTHONPATH
    pip install -r yolo/python/requirements.txt

    export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
    export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
  '';

  postShellHook = ''
    ln -sf ${python.sitePackages}/* ./.venv/lib/python3.10/site-packages
  '';
}
