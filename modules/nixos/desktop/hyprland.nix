{ pkgs, lib, config, inputs, ... }:

let
  hypr-refresh = pkgs.writeShellScriptBin "hypr-refresh" (builtins.readFile ../../../scripts/hypr-refresh.sh);

in {
  options = {
    desktop.hyprland.enable = lib.mkEnableOption "Enables hyprland compositor module";
  };

  config = lib.mkIf config.desktop.hyprland.enable {

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    services.displayManager.ly = {
      enable = true;
    };

    nixpkgs.overlays = [
      (import ../../../overlays/mcmojave-cursors.nix)
    ];

    environment.systemPackages = with pkgs; [
      alacritty
      rofi # App launcher and custom menus
      dunst # Notifications
      swww # Wallpaper daemon
      nwg-displays # Display configuration gui
      inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default # McMojave Hyprcursor theme
      hyprpolkitagent # Needed for gui apps to request admin privilege
      brightnessctl
      nwg-look
      qt6ct
      libsForQt5.qt5ct
      hyprshot # Screenshot utility
      mcmojave-cursors # from my overlay
      bluetuith
    ];

    programs.waybar.enable = true;
    
    programs.hyprlock.enable = true;
    services.hypridle.enable = true;

    services.blueman.enable = true;

    systemd.user.services.hypr-refresh = {
      enable = true;
      description = "Adjust Hyprland refresh rate based on AC/BAT state";
      wantedBy = [ "default.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${hypr-refresh}/bin/hypr-refresh";
      };
    };

    services.udev.extraRules = ''
      SUBSYSTEM=="power_supply", KERNEL=="AC", ACTION=="change", \
      ENV{SYSTEMD_USER_WANTS}+="hypr-refresh.service"
    '';
  };
}

