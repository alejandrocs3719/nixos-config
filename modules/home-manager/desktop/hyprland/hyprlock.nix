{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.desktop.hyprland.enable {
    programs.hyprlock = {
      enable = true;

      settings = {
        general = {
          hide_cursor = false;
        };

        animations = {
          enabled = true;
          bezier = "linear, 1, 1, 0, 0";
          animation = [
            "fadeIn, 1, 5, linear"
            "fadeOut, 1, 5, linear"
            "inputFieldDots, 1, 2, linear"
          ];
        };

       background = {
          monitor = "";
          path = "screenshot";
          blur_passes = 3;
         };

        input-field = {
            monitor = "";
            size = "25%, 6%"; # scales with screen size
            outline_thickness = 0;
	    # inner_color = "rgba(200, 200, 200, 200)";
	    # outer_color = "rgba(00ff99ee) rgba(00ff99ee) 45deg";
	    # check_color = "rgba(00ff99ee) rgba(ff6633ee) 120deg";
	    # fail_color = "rgba(ff6633ee) rgba(ff0066ee) 40deg";
	    # font_color = "rgb(143, 143, 143)";
            fade_on_empty = false;
            rounding = 15;
            font_family = "JetBrains Mono Nerd Font";
            placeholder_text = "Input password...";
            fail_text = "$PAMFAIL";
            dots_spacing = 0.3;
            hide_input = true;

            # centered horizontally and slightly below center vertically
            position = "0, -10%";
            halign = "center";
            valign = "center";
          };

        label = [
          # Time label
          {
            monitor = "";
            text = "$TIME";
            font_size = 12;
            font_family = "JetBrains Mono Nerd Font";

            # centered horizontally, 20% above center vertically
            position = "0, 20%";
            halign = "center";
            valign = "center";
          }

          # Date label
          {
            monitor = "";
            text = ''cmd[update:60000] date +"%A, %d %B %Y"'';
            font_size = 4;
            font_family = "JetBrains Mono Nerd Font";

            # centered horizontally, 10% above center vertically
            position = "0, 10%";
            halign = "center";
            valign = "center";
          }

          # Keyboard layout switcher
          {
            monitor = "";
            text = "$LAYOUT[en,es]";
            font_size = 3.5;
            onclick = "hyprctl switchxkblayout all next";

            # positioned 20% to the right of center, aligned with input field
            position = "20%, -10%";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };

}
