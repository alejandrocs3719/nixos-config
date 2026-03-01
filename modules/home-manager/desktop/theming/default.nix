{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  cfg = config.modules.desktop.theming;
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  themePath = "${config.home.homeDirectory}/.nixos-config/modules/home-manager/desktop/theming/themes";
  scriptPath = "${config.home.homeDirectory}/.nixos-config/modules/home-manager/desktop/theming/scripts";
in
{
  options.modules.desktop.theming.enable = lib.mkEnableOption "Enables my custom theming module, including theme switcher";

  config = lib.mkIf cfg.enable {
    # mkOutOfStoreSymlink when this module in enabled
    xdg.configFile."hypr/hyprland.conf".source = create_symlink "${confPath}/hypr/hyprland.conf";
    xdg.configFile."hypr/hypridle.conf".source = create_symlink "${confPath}/hypr/hypridle.conf";
    xdg.configFile."hypr/hyprlock.conf".source = create_symlink "${confPath}/hypr/hyprlock.conf";
    xdg.configFile."hypr/hyprpaper.conf".source = create_symlink "${confPath}/hypr/hyprpaper.conf";
    xdg.configFile."hypr/hyprsunset.conf".source = create_symlink "${confPath}/hypr/hyprsunset.conf";

    xdg.configFile."hyprdynamicmonitors/hyprconfigs/" = {
       source = create_symlink "${confPath}/hyprdynamicmonitors/hyprconfigs/";
       recursive = true;
    };


    home.packages = with pkgs; [
      hyprpaper # Wallpaper
      hyprdynamicmonitors # Dynamic monitor management for hyprland
    ];
    
  };
}
