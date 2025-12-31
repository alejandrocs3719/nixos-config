{ lib, config, ... }:
{
  config = lib.mkIf config.desktop.hyprland.enable {

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null; # To use home-manager and nixos module at the same time

    };
  };

}
