{ lib, pkgs, config, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hyprscrolling
    ];
  };
}