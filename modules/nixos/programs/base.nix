{ pkgs, lib, config, ... }: {
  
  options = {
    base.enable = lib.mkEnableOption "Enables base module";
	
  };

  config = lib.mkIf config.base.enable {
  
  };

}
