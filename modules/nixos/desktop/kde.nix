{ pkgs, lib, config, ... }: {
  
  options = {
    desktop.plasma.enable = lib.mkEnableOption "Enables the KDE Plasma desktop environment";
  };

  config = lib.mkIf config.desktop.plasma.enable {
    services.xserver.enable = true; # optional
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
    ];

    environment.systemPackages = with pkgs; [
      alacritty
    ];

  };
}
