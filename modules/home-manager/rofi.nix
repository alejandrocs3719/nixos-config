{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    home.rofi.enable = lib.mkEnableOption "Installs Rofi";
  };

  config = lib.mkIf config.home.rofi.enable {
    programs.rofi = {
      enable = true;

      extraConfig = {
	show-icons = true;
      };




    };
  };

}
