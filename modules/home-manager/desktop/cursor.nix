{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.modules.theming.gtk.enable {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };  
  };
}
