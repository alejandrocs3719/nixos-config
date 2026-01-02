{ pkgs, lib, config, ... }:

let
  cfg = config.profiles.desktop.kdeniri;
in {
  options.profiles.desktop.kdeniri.enable = lib.mkEnableOption "Enables my kdeniri configuration";

  imports = [
    #./env-vars.nix # My environment variables are on a separate file.
  ];

  config = lib.mkIf cfg.enable {

    modules.desktop.kde.enable = true;
    modules.desktop.niri.enable = true;

    modules.programs.thunar.enable = false; # We are using KDE's Dolphin 


  };
}

