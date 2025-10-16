{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    home.yazi.enable = lib.mkEnableOption "Installs Yazi";
  };

  config = lib.mkIf config.home.yazi.enable {
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };

}
