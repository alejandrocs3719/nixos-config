{ pkgs, lib, config, ... }:

let
  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland.enable = lib.mkEnableOption "Enables Hyprland home manager configuration";

  imports = [
    ./hyprland.nix
    ./config.nix
    ./hyprlock.nix
    ./env-vars.nix
    ./hypridle.nix
    ./plugins.nix
  ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ ];
  };
}

