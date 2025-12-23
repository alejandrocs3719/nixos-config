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
      systemdTarget = "hyprland-session.target";
	    #systemdTarget = "graphical-session.target";

      profiles = {
        undocked = {
          outputs = [
            {
              criteria = "eDP-1";
              scale = 1.25;
              status = "enable";
            }
          ];
        };

        office2 = {
          outputs = [
            {
              criteria = "ASUSTek COMPUTER INC VG27AQ1A M5LMQS016788";
              position = "0,0";
              scale = 1.0;
              mode = "2560x1440@144Hz";
            }
            {
              criteria = "eDP-1";
              status = "disable";
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
