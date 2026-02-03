{ lib, config, ... }:

let
  cfg = config.modules.desktop.hyprland;

  host = config.networking.hostName or "";

  # Common environment variables for all hosts
  commonEnvLines = [
    "env = NIXOS_OZONE_WL,1"
    "env = MOZ_ENABLE_WAYLAND,1"
  ];

  # Specific environment variables depending of host
  hostSpecificEnvLines =
    if host == "nixgrandete" then
      [
      ]
    else if host == "nixandrete" then
      [
        "env = AQ_DRM_DEVICES, /dev/dri/intel-igpu:/dev/dri/nvidia-dgpu"
      ]
    else
      [
      ];

  envLines = commonEnvLines ++ hostSpecificEnvLines;

in
{
  config = lib.mkIf cfg.enable {
    xdg.configFile."hypr/env-vars.conf".text = lib.concatStringsSep "\n" envLines + "\n";
  };
}

