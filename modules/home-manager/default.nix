{ pkgs, lib, ... }: {

  imports = [
    ./desktop/kanshi.nix
    ./desktop/stylix.nix
    ./desktop/kde-plasma/plasma.nix
    ./desktop/wl-sunset.nix
    ./desktop/swayosd.nix
    ./desktop/hyprland
    ./yazi.nix
    ./libreoffice.nix
    ./dolphin.nix
    ./onlyoffice.nix
    ./desktop/swaync.nix
  ];

}
 
 
