{ pkgs, lib, config, ... }: {

  options = {
    home.stylix.enable = lib.mkEnableOption "Enables Stylix's home manager module";
  };

  config = lib.mkIf config.home.stylix.enable {
	
    stylix.cursor = {
      package = pkgs.mcmojave-cursors;
      name = "McMojave-cursors";
      size = 24; # It is scaled with the window
    };

  };

}
