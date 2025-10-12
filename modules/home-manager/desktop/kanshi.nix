{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    home.kanshi.enable = lib.mkEnableOption "Enables Kanshi monitor handling";
  };

  config = lib.mkIf config.home.kanshi.enable {
    services.kanshi = {
      enable = true;
      # systemdTarget = "hyprland-session.target";
      systemdTarget = "graphical-session.target";

      profiles = {
        undocked = {
          outputs = [
            {
              criteria = "eDP-1";
              scale = 1.5;
              status = "enable";
            }
          ];
        };

        office1 = {
          outputs = [
            {
              criteria = "Microstep MAG321UX OLED";
              position = "0,0";
	      scale = 1.5;
              mode = "3840x2160@240Hz";
            }
            #{
            #  criteria = "Dell Inc. DELL G3223Q 82X70P3";
            #  position = "-3840,0";
            #  mode = "1920x1080@60Hz";
            #}
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
        };
      };
    };

  };

}
