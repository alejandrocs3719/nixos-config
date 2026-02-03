{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    modules.programs.nemo.enable = lib.mkEnableOption "Nemo Home manager configuration";
  };

  config = lib.mkIf config.modules.programs.nemo.enable {
    # Create a desktop entry for Nemo:
    xdg.desktopEntries.nemo = {
      name = "Nemo";
      exec = "${pkgs.nemo-with-extensions}/bin/nemo";
    };

    # Changing the default terminal emulator for Nemo to alacritty:
    dconf = {
      settings = {
        "org/cinnamon/desktop/applications/terminal" = {
          exec = "alacritty"; # TODO: make this a variable to use in more places 
          # exec-arg = ""; # argument
        };
      };
    };

  };
}
