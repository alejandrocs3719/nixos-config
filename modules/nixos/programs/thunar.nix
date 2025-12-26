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
    };
  };

}
