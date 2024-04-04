{
  description = "rust setup overlay";

  inputs = {
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs
          {
            inherit system overlays;
            config = {
              allowUnfree = true;
            };
          };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          # buildInputs = with python310.pkgs;[
          buildInputs = with pkgs;[
            openssl
            pkg-config
            protobuf
            mold
            rust-bin.stable.latest.default
            # python310Packages.scikit-learn
            # python310Packages.xgboost
            # python310Packages.pandas
            # python310Packages.psycopg
            # python310Packages.torch-bin
            # python310Packages.torchvision-bin
            # python310Packages.matplotlib
            # python310Packages.opencv4
            # python310Packages.imutils
            # python310Packages.tqdm
            ffmpeg
            clang
            fontconfig
            zlib
            stdenv.cc.cc.lib

            libxkbcommon
            libGL
            xorg.libXcursor
            xorg.libXrandr
            xorg.libXi
            xorg.libX11
            opencv
            qt6.full
            glew
            # fmt
            # vtk
            # openmpi
            glxinfo

            vulkan-headers
            vulkan-loader
            vulkan-tools
          ];
          # LD_LIBRARY_PATH = "${lib.makeLibraryPath buildInputs}";
          LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
          # LD_LIBRARY_PATH="${nixpkgs.lib.strings.makeLibraryPath buildInputs}";

          shellHook = ''
            LD_LIBRARY_PATH=${zlib}/lib:$LD_LIBRARY_PATH:${libxkbcommon}/lib:$LD_LIBRARY_PATH:${libGL}/lib:$LD_LIBRARY_PATH:${xorg.libXcursor}/lib:$LD_LIBRARY_PATH:${xorg.libXrandr}/lib:$LD_LIBRARY_PATH:${xorg.libXi}/lib:$LD_LIBRARY_PATH:${xorg.libX11}/lib:$LD_LIBRARY_PATH:${vulkan-headers}/lib:$LD_LIBRARY_PATH:${vulkan-loader}/lib:$LD_LIBRARY_PATH:${vulkan-tools}/lib:$LD_LIBRARY_PATH
                LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib.outPath}/lib:$LD_LIBRARY_PATH
                LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib:$LD_LIBRARY_PATH;
                export ORT_DYLIB_PATH=/home/jon/Downloads/onnxruntime-linux-x64-1.17.0/lib/libonnxruntime.so.1.17.0
                export WINIT_UNIX_BACKEND=x11
                export WGPU_BACKEND=vulkan
          '';
        };
      }
    );
}
