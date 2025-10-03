{ pkgs, lib, ... }: {

  imports = [
    ./programs/steam.nix
    ./services/asus.nix
    ./services/low-power.nix
    ./desktop/hyprland.nix
  ];

}
 
  
