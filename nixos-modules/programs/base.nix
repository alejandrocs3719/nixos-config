{ pkgs, lib, config, ... }: {
  
  options = {
    base.enable = libMkEnableOption "Enables base module";
	
  };

  config = lib.mkIf config.base.enable {
  
  };

}
