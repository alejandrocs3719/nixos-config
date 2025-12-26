{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    home.waybar.enable = lib.mkEnableOption "Enables Waybar's home manager module";
  };

  config = lib.mkIf config.home.waybar.enable {
    programs.waybar = {
      enable = true;
      style = ''
        	
        /*
            @define-color bg    #1a1b26;
            @define-color fg    #a9b1d6;
            @define-color blk   #32344a;
            @define-color red   #f7768e;
            @define-color grn   #9ece6a;
            @define-color ylw   #e0af68;
            @define-color blu   #7aa2f7;
            @define-color mag   #ad8ee6;
            @define-color cyn   #0db9d7;
            @define-color brblk #444b6a;
            @define-color wht   #ffffff;
        */

        @define-color bg    #0E0E0E;
        @define-color fg    #D3C6AA;
        @define-color blk   #232A2E;
        @define-color red   #E67E80;
        @define-color grn   #A7C080;
        @define-color ylw   #DBBC7F;
        @define-color blu   #7FBBB3;
        @define-color mag   #D699B6;
        @define-color cyn   #83C092;
        @define-color brblk #48555B;
        @define-color wht   #FFFBef;

        * {
            /* `otf-font-awesome` is required to be installed for icons */
            font-family: JetBrainsMono Nerd Font;
            font-size: 13px;
        }

        window#waybar {
          background: @bg;
          color: @fg;
        }

        window#waybar.hidden {
            opacity: 0.2;
        }

        /*
        window#waybar.empty {
            background-color: transparent;
        }
        window#waybar.solo {
            background-color: #FFFFFF;
        }
        */

        window#waybar.termite {
            background-color: #3F3F3F;
        }

        window#waybar.chromium {
            background-color: #000000;
            border: none;
        }

        button {
            /* Use box-shadow instead of border so the text isn't offset */
            box-shadow: inset 0 -3px transparent;
            /* Avoid rounded borders under each button name */
            border: none;
            border-radius: 0;
        }

        /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
        button:hover {
            background: inherit;
            box-shadow: inset 0 -3px #ffffff;
        }

        /* you can set a style on hover for any module like this */
        #pulseaudio:hover {
            background-color: #a37800;
        }

        #workspaces button {
            padding: 0 6px;
            color: @cyn;
            background: transparent;
            border-bottom: 3px solid @bg;
        }
        #workspaces button.active {
            color: @cyn;
            border-bottom: 3px solid @mag;
        }
        #workspaces button.empty {
            color: @wht;
        }
        #workspaces button.empty.active {
            color: @cyn;
            border-bottom: 3px solid @mag;
        }

        #mode {
            background-color: #64727D;
            box-shadow: inset 0 -3px #ffffff;
        }

        #clock,
        #custom-sep,
        #custom-nixos-icon
        #battery,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #backlight,
        #network,
        #pulseaudio,
        #wireplumber,
        #custom-media,
        #tray,
        #mode,
        #idle_inhibitor,
        #scratchpad,
        #power-profiles-daemon,

        #tray {
            padding: 0 8px;
            color: @white;
        }


        #custom-sep {
            color: @brblk;
        }

        #custom-nixos-icon {
            color : @blu;
            font-size: 18px;
            margin-left: 5px;
            padding: 0px 11px 0px 8px;
        }


        #window,
        #workspaces {
            margin: 0 4px;
        }

        /* If workspaces is the leftmost module, omit left margin */
        .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
        }

        /* If workspaces is the rightmost module, omit right margin */
        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }
        #clock {
            color: @cyn;
            border-bottom: 4px solid @cyn;
        }

        #battery {
            color: @mag;
            border-bottom: 4px solid @mag;
        }

        #disk {
            color: @ylw;
            border-bottom: 4px solid @ylw;
        }

        #memory {
            color: @mag;
            border-bottom: 4px solid @mag;
        }

        #cpu {
            color: @grn;
            border-bottom: 4px solid @grn;
        }

        #network {
            color: @blu;
            border-bottom: 4px solid @blu;
        }

        #wireplumber {
            color: @red;
            border-bottom: 4px solid @red;
        }

        #wireplumber.muted {
        }

        #battery.charging, #battery.plugged {
            color: #ffffff;
            background-color: #26A65B;
        }

        @keyframes blink {
            to {
                background-color: #ffffff;
                color: #000000;
            }
        }

        /* Using steps() instead of linear as a timing function to limit cpu usage */
        #battery.critical:not(.charging) {
            background-color: #f53c3c;
            color: #ffffff;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: steps(12);
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        #power-profiles-daemon {
            padding-right: 15px;
        }

        #power-profiles-daemon.performance {
            background-color: #f53c3c;
            color: #ffffff;
        }

        #power-profiles-daemon.balanced {
            background-color: #2980b9;
            color: #ffffff;
        }

        #power-profiles-daemon.power-saver {
            background-color: #2ecc71;
            color: #000000;
        }

        label:focus {
            background-color: #000000;
        }

        #backlight {
            background-color: #90b1b1;
        }

        #network.disconnected {
            background-color: #f53c3c;
        }

        #pulseaudio {
            background-color: #f1c40f;
            color: #000000;
        }

        #pulseaudio.muted {
            background-color: #90b1b1;
            color: #2a5c45;
        }

        #custom-media {
            background-color: #66cc99;
            color: #2a5c45;
            min-width: 100px;
        }

        #custom-media.custom-spotify {
            background-color: #66cc99;
        }

        #custom-media.custom-vlc {
            background-color: #ffa000;
        }

        #temperature {
            background-color: #f0932b;
        }

        #temperature.critical {
            background-color: #eb4d4b;
        }

        #tray {
            /* background-color or smth */
        }

        #tray > .passive {
            -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
            -gtk-icon-effect: highlight;
        }

        #idle_inhibitor {
            background-color: #2d3436;
        }

        #idle_inhibitor.activated {
            background-color: #ecf0f1;
            color: #2d3436;
        }

        #mpd {
            background-color: #66cc99;
            color: #2a5c45;
        }

        #mpd.disconnected {
            background-color: #f53c3c;
        }

        #mpd.stopped {
            background-color: #90b1b1;
        }

        #mpd.paused {
            background-color: #51a37a;
        }

        #language {
            background: #00b093;
            color: #740864;
            padding: 0 5px;
            margin: 0 5px;
            min-width: 16px;
        }

        #keyboard-state {
            background: #97e1ad;
            color: #000000;
            padding: 0 0px;
            margin: 0 5px;
            min-width: 16px;
        }

        #keyboard-state > label {
            padding: 0 5px;
        }

        #keyboard-state > label.locked {
            background: rgba(0, 0, 0, 0.2);
        }

        #scratchpad {
            background: rgba(0, 0, 0, 0.2);
        }

        #scratchpad.empty {
        	background-color: transparent;
        }

        #privacy {
            padding: 0;
        }

        #privacy-item {
            padding: 0 5px;
            color: white;
        }

        #privacy-item.screenshare {
            background-color: #cf5700;
        }

        #privacy-item.audio-in {
            background-color: #1ca000;
        }

        #privacy-item.audio-out {
            background-color: #0069d4;
        }

        	
      '';

      settings = [
        {
          height = 30;
          spacing = 4;

          modules-left = [
            "custom/nixos-icon"
            "hyprland/workspaces"
            "hyprland/window"
          ];

          modules-center = [
            "sway/window"
          ];

          modules-right = [
            "tray"
            "custom/sep"
            "network"
            "custom/sep"
            "cpu"
            "custom/sep"
            "memory"
            "custom/sep"
            "disk"
            "custom/sep"
            "wireplumber"
            "custom/sep"
            "battery"
            "custom/sep"
            "clock"
          ];

          "custom/nixos-icon" = {
            format = "";
            on-click = "rofi -show drun -theme ~/.config/rofi/config.rasi";
            on-click-right = "killall rofi";
            tooltip = false;
          };

          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            warp-on-scroll = false;
            format = "{name}";
            persistent-workspaces = {
              "*" = 9;
            };
          };

          "hyprland/window" = {
            max-length = 40;
            separate-outputs = false;
          };

          "keyboard-state" = {
            numlock = true;
            capslock = true;
            format = "{name} {icon}";
            format-icons = {
              locked = "";
              unlocked = "";
            };
          };

          "sway/mode" = {
            format = "<span style=\"italic\">{}</span>";
          };

          "sway/scratchpad" = {
            format = "{icon} {count}";
            show-empty = false;
            format-icons = [
              ""
              ""
            ];
            tooltip = true;
            tooltip-format = "{app}: {title}";
          };

          mpd = {
            format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
            format-disconnected = "Disconnected ";
            format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
            unknown-tag = "N/A";
            interval = 5;
            consume-icons.on = " ";
            random-icons = {
              off = "<span color=\"#f53c3c\"></span> ";
              on = " ";
            };
            repeat-icons.on = " ";
            single-icons.on = "1 ";
            state-icons = {
              paused = "";
              playing = "";
            };
            tooltip-format = "MPD (connected)";
            tooltip-format-disconnected = "MPD (disconnected)";
          };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };

          tray = {
            spacing = 10;
          };

          clock = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
          };

          cpu = {
            format = " {usage}%";
            tooltip = false;
          };

          memory = {
            interval = 10;
            format = " {used:0.2f}GiB";
            max-length = 10;
            tooltip = false;
          };

          disk = {
            interval = 60;
            path = "/";
            format = " {free}";
          };

          temperature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = [
              ""
              ""
              ""
            ];
          };

          backlight = {
            format = "{percent}% {icon}";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
            ];
          };

          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            max-length = 25;
            tooltip = true;
            format-icons = {
              charging = [
                "󰢜"
                "󰂆"
                "󰂇"
                "󰂈"
                "󰢝"
                "󰂉"
                "󰢞"
                "󰂊"
                "󰂋"
                "󰂅"
              ];
              default = [
                "<span color='#f38ba8'></span> "
                "<span color='#f38ba8'></span> "
                "<span color='#f9e2af'></span> "
                "<span color='#a6e3a1'></span> "
                "<span color='#a6e3a1'></span> "
              ];
            };
          };

          battery1 = {
            states = {
              good = 80;
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-full = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };

          "battery#bat2" = {
            bat = "BAT2";
          };

          power-profiles-daemon = {
            format = "{icon}";
            tooltip-format = "Power profile: {profile}\nDriver: {driver}";
            tooltip = true;
            format-icons = {
              default = "";
              performance = "";
              balanced = "";
              power-saver = "";
            };
          };

          network = {
            interval = 10;
            format-wifi = "  {essid}";
            format-ethernet = " ";
            format-disconnected = " ";
            tooltip-format-wifi = "{essid} ({signalStrength}%)";
            tooltip-format-ethernet = "{ifname} ";
          };

          network1 = {
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };

          pulseaudio = {
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = "pavucontrol";
          };

          "custom/media" = {
            format = "{icon} {text}";
            return-type = "json";
            max-length = 40;
            format-icons = {
              spotify = "";
              default = "🎜";
            };
            escape = true;
            exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
          };

          "custom/power" = {
            format = "⏻ ";
            tooltip = false;
            menu = "on-click";
            menu-file = "$HOME/.config/waybar/power_menu.xml";
            menu-actions = {
              shutdown = "shutdown";
              reboot = "reboot";
              suspend = "systemctl suspend";
              hibernate = "systemctl hibernate";
            };
          };

          "custom/sep" = {
            format = "|";
            interval = 0;
            tooltip = false;
          };

          wireplumber = {
            format = "{icon}  {volume}%";
            format-muted = " Muted";
            format-icons = [
              ""
              ""
              ""
            ];
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            scroll-step = 5;
          };

          "wireplumber#sink" = {
            format = "{volume}% {icon}";
            format-muted = "";
            format-icons = [
              ""
              ""
              ""
            ];
            on-click = "helvum";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            scroll-step = 5;
          };

          "wireplumber#source" = {
            node-type = "Audio/Source";
            format = "{volume}% ";
            format-muted = "";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
            scroll-step = 5;
          };
        }
      ];
    };

  };

}
