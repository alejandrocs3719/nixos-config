{ pkgs, lib, config, ... }: {
  
  options = {
    tlp.enable = lib.mkEnableOption "Enables TLP Module for battery savings";
  };

  config = lib.mkIf config.tlp.enable {

  };

}
