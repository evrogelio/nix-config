{
  description = "Main flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, ... }@inputs: 
    let 
      lib =  nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
	        inherit system;
          specialArgs = { inherit inputs; };
	        modules = [
	          ./configuration.nix
	          home-manager.nixosModules.home-manager {
	            home-manager.useGlobalPkgs = true;
	            home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
	            home-manager.users.rogelioev = import ./home.nix;
	          }
	        ];
	      };        
      };

      homeConfigurations.rogelioev = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
}

