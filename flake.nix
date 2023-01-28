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
      modules = [ ./configuration.nix ./home-desktop/hardware-configuration.nix ];
    };

    nixosConfigurations.jon-work-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      specialArgs = attrs;
      modules = [ ./configuration.nix ./work-desktop/hardware-configuration.nix ];
    };
  };
}
