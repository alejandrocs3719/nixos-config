{ pkgs, lib, config, ... }:

let
  cfg = config.modules.desktop.niri;
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  confPath = "${config.home.homeDirectory}/.nixos-config/modules/home-manager/desktop/niri/config";
in {
  options.modules.desktop.niri.enable = lib.mkEnableOption "Enables my Niri configuration";

  imports = [
  ];

  config = lib.mkIf cfg.enable {

    # mkOutOfStoreSymlink when this module in enabled
    xdg.configFile."niri" = {
      source = create_symlink "${confPath}";
      recursive = true;
    };

    
  };
}

