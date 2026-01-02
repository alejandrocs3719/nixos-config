{ lib, config, ... }:
{
  config = lib.mkIf config.modules.desktop.kde.enable {
      environment.sessionVariables = {
        KWIN_FORCE_ASSUME_HDR_SUPPORT = "1";
        NIXOS_OZONE_WL = "1"; # Helps with Electron apps on Wayland
        MOZ_ENABLE_WAYLAND = "1"; # Makes Firefox run on Wayland
      };
  };
}