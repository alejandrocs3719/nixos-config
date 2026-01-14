{
  description = "NixOS Flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # Prevent home manager from pulling its own version from nixpkgs avoiding mismatches package sets
    };

    mcmojave-hyprcursor.url = "github:libadoxon/mcmojave-hyprcursor"; # McMojave cursor for hyprcursor
    
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";

  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      plasma-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        nixandrete = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/laptop/configuration.nix
            stylix.nixosModules.stylix
            ./modules/nixos
            ./profiles/nixos
	          ./noctalia.nix
            home-manager.nixosModules.home-manager
	          inputs.nix-gaming.nixosModules.platformOptimizations
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                users.alejandro = {
                  imports = [
                    ./hosts/laptop/home.nix
                    ./modules/home-manager
                  ];
                };
                backupFileExtension = "backup"; # If config file I downloaded already exist, it will be moved to backup directory
              };

            }
          ];
        }; # nixandrete

        nixgrandete = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/pc/configuration.nix
            stylix.nixosModules.stylix
            ./modules/nixos
            ./profiles/nixos
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                useUserPackages = true;
                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                users.alejandro = {
                  imports = [
                    ./hosts/pc/home.nix
                    ./modules/home-manager
                  ];
                };
                backupFileExtension = "backup"; # If config file I downloaded already exist, it will be moved to backup directory
              };

            }
          ];
        }; # nixgrandete

      }; # nixconfigurations

    }; # outputs

}
