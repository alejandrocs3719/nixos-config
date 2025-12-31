{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.desktop.hyprland.enable {
    wayland.windowManager.hyprland.plugins = [
      pkgs.hyprlandPlugins.hyprsplit # Split monitor workspaces like dwm
    ];
    wayland.windowManager.hyprland.settings = {
      # For the split monitor workspaces to work correctly:
    # unbind = [ # we first unbind the original hotkeys to then bind the new ones
    #   "$mainMod, 1"
    #   "$mainMod, 2"
    #   "$mainMod, 3"
    #   "$mainMod, 4"
    #   "$mainMod, 5"
    #   "$mainMod, 6"

    #   "$mainMod SHIFT, 1"
    #   "$mainMod SHIFT, 2"
    #   "$mainMod SHIFT, 3"
    #   "$mainMod SHIFT, 4"
    #   "$mainMod SHIFT, 5"
    #   "$mainMod SHIFT, 6"
    # ];

      bind = [
        "$mainMod, 1, split:workspace, 1"
        "$mainMod, 2, split:workspace, 2"
        "$mainMod, 3, split:workspace, 3"
        "$mainMod, 4, split:workspace, 4"
        "$mainMod, 5, split:workspace, 5"
        "$mainMod, 6, split:workspace, 6"
        "$mainMod, 7, split:workspace, 7"
        "$mainMod, 8, split:workspace, 8"
        "$mainMod, 9, split:workspace, 9"
        "$mainMod, 0, split:workspace, 0"

        "$mainMod SHIFT, 1, split:movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, split:movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, split:movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, split:movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, split:movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, split:movetoworkspacesilent, 6"
	"$mainMod SHIFT, 7, split:movetoworkspacesilent, 7"
	"$mainMod SHIFT, 8, split:movetoworkspacesilent, 8"
	"$mainMod SHIFT, 9, split:movetoworkspacesilent, 9"
	"$mainMod SHIFT, 0, split:movetoworkspacesilent, 0"

        "$mainMod, D, split:swapactiveworkspaces, current +1"
        "$mainMod, G, split:grabroguewindows"
      ];
    };
  };

}
