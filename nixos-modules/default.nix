{ pkgs, lib, ... }: {

  imports = [
    ./programs/steam.nix
    ./services/low-power.nix
  ];

}
 
  
