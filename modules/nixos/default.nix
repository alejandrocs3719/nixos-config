{ pkgs, lib, ... }: {

  imports = [
    ./programs/steam.nix
    ./services/asus.nix
    ./services/low-power.nix
    ./desktop/hyprland.nix
    ./services/amdgpu.nix
    ./desktop/stylix.nix
    ./services/bluetooth.nix
    ./desktop/kde.nix
  ];

}
 
  
