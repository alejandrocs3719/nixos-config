{ lib, config, ... }:
{
  config = lib.mkIf config.modules.desktop.niri.enable {
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Helps with Electron apps on Wayland
        MOZ_ENABLE_WAYLAND = "1"; # Makes Firefox run on Wayland
      };
  };
}