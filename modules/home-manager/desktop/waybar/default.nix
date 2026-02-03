{ pkgs, lib, config, inputs, ... }:

let
  cfg = config.modules.desktop.gui.waybar;
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  confPath = "${config.home.homeDirectory}/.nixos-config/modules/home-manager/desktop/waybar/config";
in {
  options.modules.desktop.gui.waybar.enable = lib.mkEnableOption "Enables my Waybar configuration";

  imports = [
  ];

  config = lib.mkIf cfg.enable {
    # mkOutOfStoreSymlink when this module in enabled
    xdg.configFile."waybar/config.jsonc".source = create_symlink "${confPath}/config.jsonc";
    xdg.configFile."waybar/style.css".source = create_symlink "${confPath}/style.css";

    programs.waybar.enable = true;

    # Cannot do recursive with Nix generated config files.
    # xdg.configFile."hypr" = {
    #   source = create_symlink "${confPath}";
    #   recursive = true;
    # };




    # Bar
    
  };
}

