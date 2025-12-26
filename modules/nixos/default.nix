{ pkgs, lib, ... }: {

  imports = [
    ./gaming
    ./media
    ./services/sunshine
    ./desktop/niri
    ./services/asus.nix
    ./services/low-power.nix
    ./desktop/hyprland.nix
    ./services/amdgpu.nix
    ./desktop/stylix.nix
    ./services/bluetooth.nix
    ./desktop/kde.nix
    ./services/nvidia
    ./services/tuned.nix
    ./services/power-profiles-daemon.nix
    ./services/intel-graphics.nix
    ./programs/thunar.nix
  ];

}
 
  
