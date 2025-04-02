{
  # See https://discourse.nixos.org/t/problems-after-switching-to-flake-system/24093/7 for details
  inputs =
    {
      nixpkgs.url = "nixpkgs/nixos-unstable";
      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = { self, nixpkgs, home-manager, ... }@attrs: {
    nixosConfigurations.jon = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      specialArgs = attrs;
      modules = [ ./configuration.nix ./home-desktop/hardware-configuration.nix ./home-desktop/settings.nix ./nvidia-4090.nix ];
    };

    nixosConfigurations.jon-work-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      specialArgs = attrs;
      modules = [ ./configuration.nix ./jon-work-desktop/hardware-configuration.nix ./jon-work-desktop/settings.nix ./nvidia-4090.nix ];
    };

    nixosConfigurations.work-node = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      specialArgs = attrs;
      modules = [ ./configuration.nix ./work-node/hardware-configuration.nix ./work-node/settings.nix ./github-runner.nix ./nvidia-4090.nix ];
    };

    nixosConfigurations.jon-work-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      specialArgs = attrs;
      modules = [ ./configuration.nix ./jon-work-laptop/hardware-configuration.nix ./jon-work-laptop/settings.nix ./intel-integrated-gpu.nix ];
    };
  };
}
