{ pkgs ? (import <nixpkgs> { config.allowUnfree = true; }) }:

let
  python = pkgs.python312;
  pythonPackages = python.pkgs;
  libPath = with pkgs; lib.makeLibraryPath [
    # load external libraries that you need in your rust project here
    cudatoolkit
    cudaPackages.libcublas
    cudaPackages.cudnn
    cudaPackages.libcurand
    cudaPackages.libcufft
    libXcursor
    libXrandr
    libXi
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
    fontconfig

    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav

    # https://discourse.nixos.org/t/how-to-correctly-populate-a-clang-and-llvm-development-environment-using-nix-shell/3864/5
    rustPlatform.bindgenHook

    # flamegraph
    # zlib
    # libGL
    # glib

    python
    pythonPackages.pip
  ];

  LD_LIBRARY_PATH = libPath;

  shellHook = ''
    export LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib:$LD_LIBRARY_PATH;
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib/:$LD_LIBRARY_PATH;

    SOURCE_DATE_EPOCH=$(date +%s)
    VENV=.venv

    export PYO3_PYTHON="$(which python)"
    export PYTHON_SYS_EXECUTABLE="$(which python)"

    if test ! -d $VENV; then
      python -m venv $VENV
    fi

    source ./$VENV/bin/activate
    export PYTHONPATH=`pwd`/$VENV/${python.sitePackages}/:$PYTHONPATH

    # pip install --upgrade pip
    pip install -r src/yolo/python/requirements.txt
    # pip install --no-build-isolation bytetracker

    export PATH=$PATH:''${CARGO_HOME:-~/.config/.cargo}/bin
    export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
  '';

  postShellHook = ''
    ln -sf ${python.sitePackages}/* ./.venv/lib/python3.12/site-packages
  '';
}



