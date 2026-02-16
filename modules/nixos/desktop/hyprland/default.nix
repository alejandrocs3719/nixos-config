{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  cfg = config.modules.desktop.hyprland;
in
{
  options.modules.desktop.hyprland.enable = lib.mkEnableOption "Enables my Hyprland configuration";

  imports = [
    # ./env-vars.nix # My environment variables are on a separate file.
    ./plugins.nix # System managed plugins
  ];

  config = lib.mkIf cfg.enable {

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };


    # Custom nixpkgs overlay for bibata hyprcursor:
    nixpkgs.overlays = [
      (import ../../../../overlays/bibata-hyprcursor.nix)
    ];


    environment.systemPackages = with pkgs; [
      alacritty # Terminal of my choosing and Hyprland's default
      brightnessctl
      rofi # launcher of choice, not managed by home manager
      impala # network management tui
      bluetui # bluetooth device selection tui
      wiremix # output device selection tui
      nwg-displays # Display configuration gui
     #inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default # McMojave Hyprcursor theme
      hyprpolkitagent # Needed for gui apps to request admin privilege
      grim # Screenshot utility
      slurp # Select part of the screen
      hypridle # Idle daemon
      wl-clipboard
      file-roller # archive manager
      bibata-modern-classic-hyprcursor
    ];

    services.displayManager.sddm = {
	  enable = true;
	  wayland = {
	    enable = true;

	    # default compositor is "weston", you can optionally change it to kwin
	    #compositor = "kwin";
	  };
     };

    # Ly Display Manager to launch Hyprland:
  # services.displayManager.ly = {
  #   enable = true;
  #   settings = {
  #     animation = "gameoflife";
  #     gameoflife_frame_delay = 10;
  #     gameoflife_fg = "0x0000FF00";
  #     gameoflife_initial_density = 0.4;
  #     gameoflife_entropy_interval = 0;
  #   };
  # };
    # systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE"; # Fixes problems with swayidle's service not meeting conditions to start

  };
}
