{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  hypr-refresh = pkgs.writeShellScriptBin "hypr-refresh" (
    builtins.readFile ../../../scripts/hypr-refresh.sh
  );

in
{
  options = {
    modules.desktop.hyprland.enable = lib.mkEnableOption "Enables hyprland compositor module";
  };

  config = lib.mkIf config.modules.desktop.hyprland.enable {

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    services.displayManager.ly = {
      enable = true;
    };

    services.udev.extraRules = ''
      # Intel iGPU
      KERNEL=="card*", \
        KERNELS=="0000:00:02.0", \
        SUBSYSTEM=="drm", \
        SUBSYSTEMS=="pci", \
        SYMLINK+="dri/intel-igpu"

      # NVIDIA dGPU
      KERNEL=="card*", \
        KERNELS=="0000:01:00.0", \
        SUBSYSTEM=="drm", \
        SUBSYSTEMS=="pci", \
        SYMLINK+="dri/nvidia-dgpu"
    '';

    environment.systemPackages = with pkgs; [
      alacritty
	    #rofi # App launcher and custom menus
	    #dunst # Notifications
      swww # Wallpaper daemon
      nwg-displays # Display configuration gui
      inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default # McMojave Hyprcursor theme
      hyprpolkitagent # Needed for gui apps to request admin privilege
      brightnessctl
	    #swayosd # OSD for volume or brightness changing
      nwg-look
	    #qt6Packages.qt6ct
	    #libsForQt5.qt5ct
      hyprshot # Screenshot utility
      bluetuith
      blueberry
      impala
    ];

	#programs.waybar.enable = true;

    # programs.hyprlock.enable = true;
    # services.hypridle.enable = true;

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

	# services.udev.extraRules = ''
	#SUBSYSTEM=="power_supply", KERNEL=="AC", ACTION=="change", \
	#ENV{SYSTEMD_USER_WANTS}+="hypr-refresh.service"
	#'';
  };
}
