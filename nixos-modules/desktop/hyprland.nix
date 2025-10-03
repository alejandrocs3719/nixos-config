{ pkgs, lib, config, ... }:

let
  hypr-refresh = pkgs.writeShellScriptBin "hypr-refresh" (builtins.readFile ../../scripts/hypr-refresh.sh);

in {
  options = {
    desktop.hyprland.enable = lib.mkEnableOption "Enables hyprland compositor module";
  };

  config = lib.mkIf config.desktop.hyprland.enable {

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    services.displayManager.ly.enable = true;

    environment.systemPackages = with pkgs; [
      alacritty
      rofi
      dunst
      swww
      hyprsunset
      hypr-refresh
    ];

    programs.waybar.enable = true;

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

