{ lib, config, ... }:
{
  config = lib.mkIf config.modules.desktop.hyprland.enable {
      home.sessionVariables = {
        
      };
  };
}