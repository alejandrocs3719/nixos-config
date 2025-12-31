{ lib, pkgs, ... }:
with lib; let
  hyprPluginPkgs = pkgs.hyprlandPlugins;
  hypr-plugin-dir = pkgs.symlinkJoin {
    name = "hyprland-plugins";
    paths = with hyprPluginPkgs; [
      hyprscrolling
    ];
  };
in
{
  environment.sessionVariables = { HYPR_PLUGIN_DIR = hypr-plugin-dir; };
}