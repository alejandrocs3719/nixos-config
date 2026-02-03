{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    home.alacritty.enable = lib.mkEnableOption "Installs Alacritty";
  };

  config = lib.mkIf config.home.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
          size = 12;
        };
        window = {
          opacity = 0.8;
        };
      };
    };
  };

}
