{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    home.gtk.enable = lib.mkEnableOption "Enables my gtk theming";
  };

  config = lib.mkIf config.home.gtk.enable {
    gtk = {
      enable = true;
      theme = {
        name = "colloid-gtk-theme";
        package = pkgs.colloid-gtk-theme;
      };
      #iconTheme = {
      #  name = "Papirus-Dark";
      #  package = pkgs.catppuccin-papirus-folders.override {
      #    flavor = "mocha";
      #    accent = "lavender";
      #  };
      #};
      #cursorTheme = {
      #  name = "Catppuccin-Mocha-Light-Cursors";
      #  package = pkgs.catppuccin-cursors.mochaLight;
      #};
      #gtk3 = {
      #  extraConfig.gtk-application-prefer-dark-theme = true;
      #};
    };
  };

}
