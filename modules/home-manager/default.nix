{ pkgs, lib, ... }: {

  imports = [
    ./desktop/kanshi.nix
    ./virtualisation
    ./gaming
    ./dev
    ./desktop/niri
    ./desktop/hyprland
    ./desktop/gtk.nix
    #./desktop/stylix.nix
    ./nemo.nix
    ./desktop/cursor.nix
    ./desktop/rofi
    ./desktop/kde-plasma/plasma.nix
    ./desktop/wl-sunset.nix
    ./desktop/waybar
    ./desktop/swayosd.nix
    ./yazi.nix
    ./libreoffice.nix
    ./dolphin.nix
    ./onlyoffice.nix
    ./desktop/swaync.nix
    ./alacritty.nix
    ./xdg.nix
  ];

}
 
 
