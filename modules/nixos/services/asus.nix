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
	supergfxd.enable = false; # they told me on the asus linux discord this was no longer needed.  
    };

  };
}
