{ lib, config, ... }:
{
  config = lib.mkIf config.desktop.hyprland.enable {
    wayland.windowManager.hyprland.settings.env = [
      "HYPRCURSOR_THEME,${config.stylix.cursor.name}"
      "HYPRCURSOR_SIZE,${toString config.stylix.cursor.size}"
      "XCURSOR_THEME,${config.stylix.cursor.name}"
      "XCURSOR_SIZE,${toString config.stylix.cursor.size}"
      "NIXOS_OZONE_WL,1"
    ];

  };

}
