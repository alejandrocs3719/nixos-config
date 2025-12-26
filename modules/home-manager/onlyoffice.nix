{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    home.onlyoffice.enable = lib.mkEnableOption "Installs onlyoffice";
  };

  config = lib.mkIf config.home.onlyoffice.enable {
    programs.onlyoffice = {
      enable = true;

    };
  };

}
