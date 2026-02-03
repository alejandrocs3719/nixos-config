{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    modules.theming.gtk.enable = lib.mkEnableOption "Enables my gtk theming";
  };

  config = lib.mkIf config.modules.theming.gtk.enable {

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    gtk = {
      enable = true;

     theme = {
       name = "Colloid-Green";
       package = pkgs.colloid-gtk-theme.override {
          #colorVariants = [ "dark" ];
         themeVariants = [ "green" ];
         tweaks = [
           "black"
         ];
       };
     };

      font = {
        name = "Rubik Regular";
        package = pkgs.rubik;
      };

      iconTheme = {
        name = "Mint-Y";
        package = pkgs.mint-y-icons;
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
      gtk3 = {
        extraConfig.gtk-application-prefer-dark-theme = true;
      };
    };
  

  };

}
