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
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      sharedHomeManager = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.rogelioev = {
          imports = [
            ./home.nix
            ./modules/cli-tools.nix
            ./modules/desktop.nix
          ];
        };
      };
    in {
      nixosConfigurations = {
        personal-pc = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/personal-pc/configuration.nix
            home-manager.nixosModules.home-manager
            sharedHomeManager
          ];
        };        

        work-pc = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/work-pc/configuration.nix
            home-manager.nixosModules.home-manager
            sharedHomeManager
          ];
        };

        server = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/server/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.rogelioev = {
                imports = [
                  ./home.nix
                  ./modules/home/cli-tools.nix
                ];
              };
            }
          ];
        };
      };


      homeConfigurations.rogelioev = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home.nix
          ./modules/cli-tools.nix
          ./modules/desktop.nix
        ];
      };
    };
}
