{ pkgs, lib, config, inputs, ... }:

let
  cfg = config.modules.desktop.hyprland;
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  confPath = "${config.home.homeDirectory}/.nixos-config/modules/home-manager/desktop/hyprland/config";
in {
  options.modules.desktop.hyprland.enable = lib.mkEnableOption "Enables my Hyprland configuration";

  imports = [
    ./stylix-colors.nix # Uses Stylix color palette to rice Hyprland without committing to managing Hyprland's dotfiles in Nix
    ./env-vars.nix
  ];


  config = lib.mkIf cfg.enable {
    # mkOutOfStoreSymlink when this module in enabled
    xdg.configFile."hypr/hyprland.conf".source = create_symlink "${confPath}/hyprland.conf";


    # Cannot do recursive with Nix generated config files.
    # xdg.configFile."hypr" = {
    #   source = create_symlink "${confPath}";
    #   recursive = true;
    # };

    
  };
}

