{ pkgs, lib, config, inputs, ... }:

let
  cfg = config.modules.desktop.hyprland;
in {
  options.modules.desktop.hyprland.enable = lib.mkEnableOption "Enables my Hyprland configuration";

  imports = [
    ./env-vars.nix # My environment variables are on a separate file.
  ];

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      alacritty # Terminal of my choosing and Niri's default
      brightnessctl
      impala # network management tui
      nwg-displays # Display configuration gui
      inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default # McMojave Hyprcursor theme
      hyprpolkitagent # Needed for gui apps to request admin privilege
      hyprshot # Screenshot utility
    ];

    # Ly Display Manager to launch Hyprland:
    services.displayManager.ly = {
      enable = true;
    };
    # systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE"; # Fixes problems with swayidle's service not meeting conditions to start


    # Multi-gpu setup. TODO: build this conditionally depending on the host
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
  };
}

