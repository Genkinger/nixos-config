{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";    
    musnix.url = "github:musnix/musnix";
  };
  
  outputs = { self, nixpkgs, ...}@inputs: 
  let
    system = "x86_64-linux";
    pkg-sets = final: prev: {
      stable = import inputs.stable { system = final.system; config.allowUnfree = true; };
      unstable = import inputs.unstable { system = final.system; config.allowUnfree = true;};
    };
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem 
    {
      system = system;
      modules = [
        ./configuration.nix
        ({nixpkgs.overlays = [ pkg-sets ];})
        inputs.musnix.nixosModules.musnix
      ];
    };
  };
}
