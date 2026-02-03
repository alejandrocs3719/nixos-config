{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    modules.programs.nemo.enable = lib.mkEnableOption "Installs Nemo";
  };

  config = lib.mkIf config.modules.programs.nemo.enable {

    environment.systemPackages = [
      pkgs.nemo-with-extensions
    ];
    
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
  };

}
