{
  pkgs,
  lib,
  config,
  ...
}:
{
  # it's out of default.nix!!!
  options = {
    modules.theming.stylix.enable = lib.mkEnableOption "Enables Stylix's home manager module";
  };

  config = lib.mkIf config.modules.theming.stylix.enable {

    nixpkgs.overlays = [
      (import ../../../overlays/mcmojave-cursors.nix)
    ];

    stylix = {
    
     cursor = {
       package = pkgs.mcmojave-cursors;
       name = "McMojave-cursors";
       size = 24; # It is scaled with the window
     };

      icons = {
        enable = true;
        package = pkgs.papirus-icon-theme;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
      };

      fonts = {
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };

        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };

        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
      
      opacity = {
        desktop = 0.7;
        terminal = 0.7;
      };
      
      targets = {
				vscode.enable = false; # Manually choose VSCode Theme
			};

    };

  };

}
