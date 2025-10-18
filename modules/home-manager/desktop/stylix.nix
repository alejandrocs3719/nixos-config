{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    home.stylix.enable = lib.mkEnableOption "Enables Stylix's home manager module";
  };

  config = lib.mkIf config.home.stylix.enable {

    nixpkgs.overlays = [
      (import ../../../overlays/mcmojave-cursors.nix)
    ];

    stylix = {
      cursor = {
        package = pkgs.mcmojave-cursors;
        name = "McMojave-cursors";
        size = 32; # It is scaled with the window
      };
      icons = {
        enable = true;
        package = pkgs.papirus-icon-theme;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
      };
    };

  };

}
