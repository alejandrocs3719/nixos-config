{ pkgs, lib, config, ... }: {
  
  options = {
    asus.enable = lib.mkEnableOption "Enables Asus Linux utilities for Asus laptops";
  };

  config = lib.mkIf config.asus.enable {
    services = {
	asusd = {
	  enable = true;
	  enableUserService = true;
	};
    };
  };
}
