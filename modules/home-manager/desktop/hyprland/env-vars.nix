{ lib, config, ... }:
{
  config = lib.mkIf config.desktop.hyprland.enable {
    wayland.windowManager.hyprland.settings.env = [
      "HYPRCURSOR_THEME,${config.stylix.cursor.name}"
      "HYPRCURSOR_SIZE,${toString config.stylix.cursor.size}"
      "XCURSOR_THEME,${config.stylix.cursor.name}"
      "XCURSOR_SIZE,${toString config.stylix.cursor.size}"
      "NIXOS_OZONE_WL,1"
      #"LIBVA_DRIVER_NAME,nvidia"
      #"__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "AQ_DRM_DEVICES,/dev/dri/intel-igpu:/dev/dri/nvidia-dgpu"
      #      "AQ_DRM_DEVICES,/dev/dri/intel-igpu"

    ];

  };

}
