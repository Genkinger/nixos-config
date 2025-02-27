{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    musnix.url = "github:musnix/musnix";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    pkg-sets = final: prev: {
      unstable = import inputs.unstable {
        system = final.system;
        config.allowUnfree = true;
      };
    };
  in {
    formatter."x86_64-linux" = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations.tower = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./system/common/base.nix
        ./system/common/packages.nix
        ./system/common/services.nix
        ./system/common/programs.nix
        ./system/tower/base.nix
        ./system/tower/hardware.nix
        ./system/tower/packages.nix
        ./system/tower/programs.nix
        ./system/tower/virtualization.nix
        ./system/tower/audio-production.nix
        inputs.musnix.nixosModules.musnix
        {nixpkgs.overlays = [pkg-sets];}
      ];
    };
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # ./system/common/base.nix
        # ./system/common/packages.nix
        # ./system/common/services.nix
        # ./system/common/programs.nix
        # ./system/laptop/base.nix
        ./system/laptop.nix
        ./system/laptop/hardware.nix
        # ./system/laptop/programs.nix
        # ./system/laptop/services.nix
        {nixpkgs.overlays = [pkg-sets];}
      ];
    };
  };
}
