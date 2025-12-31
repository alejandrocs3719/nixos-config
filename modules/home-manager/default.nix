{ pkgs, lib, ... }: {

  imports = [
    ./desktop/kanshi.nix
    ./gaming
    ./desktop/niri
    ./desktop/hyprland
    #./desktop/gtk.nix
    ./desktop/stylix.nix
    ./desktop/kde-plasma/plasma.nix
    ./desktop/wl-sunset.nix
    ./desktop/swayosd.nix
    ./desktop/waybar.nix
    ./yazi.nix
    ./libreoffice.nix
    ./dolphin.nix
    ./onlyoffice.nix
    ./desktop/swaync.nix
    ./alacritty.nix
    ./rofi.nix
  ];

}
 
 
