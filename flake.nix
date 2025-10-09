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
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
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
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
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
