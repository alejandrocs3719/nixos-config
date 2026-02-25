{ pkgs, lib, config, ... }:

let
  cfg = config.modules.desktop.kde;
in {
  options.modules.desktop.kde.enable = lib.mkEnableOption "Enables my KDE configuration";

  imports = [
    ./env-vars.nix # My environment variables are on a separate file.
  ];

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true; # optional
#   services.displayManager.sddm = {
#     enable = true;
#     wayland.enable = true;
#   };
    services.displayManager.plasma-login-manager.enable = true;

    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
      phonon-vlc # It installs VLC by default. I want to use MPV
    ];

    environment.systemPackages = with pkgs; [
      mpv # video player
      kdePackages.krohnkite
    ];

    fonts.packages = with pkgs; [
      rubik
    ];
  };
}

