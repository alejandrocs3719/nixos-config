{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  cfg = config.modules.desktop.hyprland;
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  confPath = "${config.home.homeDirectory}/.nixos-config/modules/home-manager/desktop/hyprland/config";
in
{
  options.modules.desktop.hyprland.enable = lib.mkEnableOption "Enables my Hyprland configuration";

  imports = [
    ./stylix-colors.nix # Uses Stylix color palette to rice Hyprland without committing to managing Hyprland's dotfiles in Nix
    ./env-vars.nix
  ];

  config = lib.mkIf cfg.enable {
    # mkOutOfStoreSymlink when this module in enabled
    xdg.configFile."hypr/hyprland.conf".source = create_symlink "${confPath}/hyprland.conf";
    xdg.configFile."hypr/hypridle.conf".source = create_symlink "${confPath}/hypridle.conf";
    xdg.configFile."hypr/hyprlock.conf".source = create_symlink "${confPath}/hyprlock.conf";
    xdg.configFile."hypr/hyprpaper.conf".source = create_symlink "${confPath}/hyprpaper.conf";
    xdg.configFile."hypr/hyprsunset.conf".source = create_symlink "${confPath}/hyprsunset.conf";

    # Cannot do recursive with Nix generated config files.
    # xdg.configFile."hypr" = {
    #   source = create_symlink "${confPath}";
    #   recursive = true;
    # };
    home.packages = with pkgs; [
      hyprpaper # Wallpaper
      hyprdynamicmonitors # Dynamic monitor management for hyprland
    ];

    # Bar
    modules.desktop.gui.waybar.enable = true;
    # Launcher
    modules.desktop.gui.rofi.enable = true;

    
    # Idle daemon
    services.hypridle.enable = true;
    # Lock screen
    programs.hyprlock.enable = true;
    # Night light
    services.hyprsunset.enable = true;

    # Monitor management with hyprdynamicmonitors
    home.hyprdynamicmonitors = {
      enable = true;
      # Or use a configuration file
      #configFile = ./config.toml;
    };
  };
}
