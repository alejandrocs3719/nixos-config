{ lib, config, ... }:
{
  config = lib.mkIf config.desktop.hyprland.enable {

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances
          before_sleep_cmd = "loginctl lock-session"; # lock before suspend
          after_sleep_cmd = "hyprctl dispatch dpms on"; # avoid pressing a key twice
        };

        listener = [
          {
            timeout = 150; # 2.5 min
            on-timeout = "brightnessctl -s set 10"; # dim backlight (avoid 0 on OLED)
            on-resume = "brightnessctl -r"; # restore backlight
          }
          {
            timeout = 150;
            on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # turn off keyboard backlight
            on-resume = "brightnessctl -rd rgb:kbd_backlight"; # restore keyboard backlight
          }
          {
            timeout = 300; # 5 min
            on-timeout = "loginctl lock-session"; # lock screen
          }
          {
            timeout = 330; # 5.5 min
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
          }
          {
            timeout = 1800; # 30 min
            on-timeout = "systemctl suspend"; # suspend PC
          }
        ];
      };

    };

  };

}
