{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    home.dolphin.enable = lib.mkEnableOption "Installs Dolphin file manager";
  };

  config = lib.mkIf config.home.dolphin.enable {
    home.packages = with pkgs; [
      kdePackages.dolphin
    ];
  };



}
