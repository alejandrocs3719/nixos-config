{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  cfg = config.modules.desktop.gui.dunst;
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  confPath = "${config.home.homeDirectory}/.nixos-config/modules/home-manager/desktop/dunst/config";
in
{
  options.modules.desktop.gui.dunst.enable = lib.mkEnableOption "Enables the dunst notification daemon module";

  config = lib.mkIf cfg.enable {
    # mkOutOfStoreSymlink when this module in enabled
    xdg.configFile."dunst/dunstrc".source = create_symlink "${confPath}/dunstrc";

    services.dunst.enable = true;

    home.packages = with pkgs; [
      libnotify
    ];
    
  };
}
