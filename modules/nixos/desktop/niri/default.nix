{ pkgs, lib, config, ... }:

let
  cfg = config.modules.desktop.niri;
in {
  options.modules.desktop.niri.enable = lib.mkEnableOption "Enables my Niri configuration";

  imports = [
    ./env-vars.nix # My environment variables are on a separate file.
  ];

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
        xwayland-satellite # For XWayland to work altogether
        alacritty # Terminal of my choosing and Niri's default
        brightnessctl
        impala # network management tui
    ];

    # Ly Display Manager to launch Niri:
    services.displayManager.ly = {
      enable = true;
    };
  };
}

