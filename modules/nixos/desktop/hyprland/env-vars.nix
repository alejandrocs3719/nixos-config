{ lib, config, ... }:
{
  config = lib.mkIf config.modules.desktop.hyprland.enable {
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Helps with Electron apps on Wayland
        MOZ_ENABLE_WAYLAND = "1"; # Makes Firefox run on Wayland
        AQ_DRM_DEVICES = "/dev/dri/intel-igpu:/dev/dri/nvidia-dgpu"; # For multi-gpu setups. TODO: conditions
        HYPRCURSOR_THEME = "McMojave";
        HYPRCURSOR_SIZE = "32";
      };
  };
}