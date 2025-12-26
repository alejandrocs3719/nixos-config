{ pkgs, lib, ... }: {

  imports = [
    ./desktop/kanshi.nix
    ./gaming
    #./desktop/gtk.nix
    ./desktop/stylix.nix
    ./desktop/kde-plasma/plasma.nix
    ./desktop/wl-sunset.nix
    ./desktop/swayosd.nix
    ./desktop/hyprland
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
 
 
