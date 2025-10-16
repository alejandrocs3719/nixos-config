{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    home.libreoffice.enable = lib.mkEnableOption "Install libreoffice";
  };

  config = lib.mkIf config.home.libreoffice.enable {

    home.packages = with pkgs; [
      libreoffice-fresh
    ];
  };

}
