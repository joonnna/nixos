
{ pkgs ? (import <nixpkgs> { config.allowUnfree = true; }) }:

let
  python = pkgs.python311;
  pythonPackages = python.pkgs;
  libPath = with pkgs; lib.makeLibraryPath [
    # load external libraries that you need in your rust project here
    cudatoolkit
    cudaPackages.libcublas
    cudaPackages.cudnn
    cudaPackages.libcurand
    cudaPackages.libcufft
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
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


    # flamegraph
    # zlib
    # libGL
    # glib

    python311
    python311Packages.pip
  ];

  LD_LIBRARY_PATH = libPath;
  LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];

  shellHook = ''
    SOURCE_DATE_EPOCH=$(date +%s)
    VENV=.venv

    # Need to expose python interpeter to pyo3 build script
    export PYO3_PYTHON="$(which python)"
    export PYTHON_SYS_EXECUTABLE="$(which python)"

    export LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib:$LD_LIBRARY_PATH;
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib/:$LD_LIBRARY_PATH;

    if test ! -d $VENV; then
      python -m venv $VENV
    fi

    source ./$VENV/bin/activate
    export PYTHONPATH=`pwd`/$VENV/${python.sitePackages}/:$PYTHONPATH

    # pip install --upgrade pip
    pip install -r src/yolo/python/requirements.txt
    # pip install --no-build-isolation bytetracker

    export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
    export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
  '';

  postShellHook = ''
    ln -sf ${python.sitePackages}/* ./.venv/lib/python3.10/site-packages
  '';
}


