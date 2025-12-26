{ pkgs, lib, config, ... }: {
  
  options = {
    modules.theming.stylix.enable = lib.mkEnableOption "Enables Stylix";
  };

  config = lib.mkIf config.modules.theming.stylix.enable {
     
    nixpkgs.overlays = [
      (import ../../../overlays/mcmojave-cursors.nix)
    ];

    stylix = {
      enable = true;
      polarity = "dark";
			# image = ./wallhaven_1j7myg.jpg;

			# Oxocarbon Dark
      base16Scheme = {
				base00 = "#161616";
				base01 = "#262626";
				base02 = "#393939";
				base03 = "#525252";
				base04 = "#dde1e6";
				base05 = "#f2f4f8";
				base06 = "#ffffff";
				base07 = "#08bdba";
				base08 = "#ee5396";
				base09 = "#ff7eb6";
				base0A = "#ff6f00";
				base0B = "#42be65";
				base0C = "#3ddbd9";
				base0D = "#33b1ff";
				base0E = "#be95ff";
				base0F = "#82cfff";
      };

			# Everforest modded:
			# base16Scheme = {
			# 	base00 = "#0E0E0E"; # background (edited)
			# 	base01 = "#232A2E"; # neutral dark (edited, palette 0)
			# 	base02 = "#48555B"; # neutral (edited, palette 8)
			# 	base03 = "#4F585E"; # neutral (edited, palette 7)
			# 	base04 = "#5D5C69"; # selection background 
			# 	base05 = "#D3C6AA"; # foreground (same as Everforest)
			# 	base06 = "#EDEADA"; # inherited from Everforest (light)
			# 	base07 = "#FFFBef"; # inherited from Everforest (lightest)
			# 	base08 = "#E67E80"; # red (same as Everforest)
			# 	base09 = "#DD9C9D"; # orange-ish pink (edited)
			# 	base0A = "#DBBC7F"; # yellow (same)
			# 	base0B = "#A7C080"; # green (same)
			# 	base0C = "#83C092"; # cyan / aqua (same)
			# 	base0D = "#7FBBB3"; # blue (same)
			# 	base0E = "#D699B6"; # magenta / purple (same)
			# 	base0F = "#514045"; # accent / brownish (edited)
      # };

    };
  };
}
