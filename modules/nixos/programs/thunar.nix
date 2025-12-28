{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    thunar.enable = lib.mkEnableOption "Installs Thunar";
  };

  config = lib.mkIf config.thunar.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin # Requires an Archive manager like file-roller, ark, etc
        thunar-volman # thunar volume manager
        thunar-vcs-plugin # subversion and git support
        thunar-media-tags-plugin # tagging and renaming features for media files
      ];
    };
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
  };

}
