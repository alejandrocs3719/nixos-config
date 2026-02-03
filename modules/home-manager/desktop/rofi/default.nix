{ pkgs, lib, config, inputs, ... }:

let
  cfg = config.modules.desktop.gui.rofi;
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  confPath = "${config.home.homeDirectory}/.nixos-config/modules/home-manager/desktop/rofi/config";
in {
  options.modules.desktop.gui.rofi.enable = lib.mkEnableOption "Enables my Rofi configuration";

  imports = [
  ];

  config = lib.mkIf cfg.enable {
    # mkOutOfStoreSymlink when this module in enabled
    xdg.configFile."rofi/config.rasi".source = create_symlink "${confPath}/config.rasi";
    xdg.configFile."rofi/colors.rasi".source = create_symlink "${confPath}/colors.rasi";
    xdg.configFile."rofi/themes/dtos-center.rasi".source = create_symlink "${confPath}/themes/dtos-center.rasi";


    # Cannot do recursive with Nix generated config files.
    # xdg.configFile."hypr" = {
    #   source = create_symlink "${confPath}";
    #   recursive = true;
    # };




    # Bar
    
  };
}

