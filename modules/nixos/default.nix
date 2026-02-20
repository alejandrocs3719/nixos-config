{ pkgs, lib, ... }: {

  imports = [
    ./gaming
    ./media
    ./virtualisation
    ./services/sunshine
    ./desktop/niri
    ./services/asus.nix
    ./services/low-power.nix
    ./desktop/hyprland
    ./services/amdgpu.nix
    ./services/ddcutil.nix
    #./desktop/stylix.nix
    ./services/bluetooth.nix
    ./desktop/kde
    ./services/nvidia
    ./services/tuned.nix
    ./services/power-profiles-daemon.nix
    ./services/intel-graphics.nix
    ./programs/thunar.nix
    ./programs/nemo.nix
  ];

}
 
  
