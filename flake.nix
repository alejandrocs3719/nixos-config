{
    description = "NixOS Flake";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs"; # Prevent home manager from pulling its own version from nixpkgs avoiding mismatches package sets
        };
    };
    
    outputs = { self, nixpkgs, home-manager, ... }: {
        nixosConfigurations.nixandrete = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./hosts/laptop/configuration.nix
		./nixos-modules
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.alejandro = import ./hosts/laptop/home.nix;
                        backupFileExtension = "backup"; # If config file I downloaded already exist, it will be moved to backup directory
                    };
                
                }
            ];
        };
    };
    


}
