{ pkgs, lib, config, ... }: {
  
  options = {
    bluetooth.enable = lib.mkEnableOption "Enables my bluetooth configuration";
  };

  config = lib.mkIf config.bluetooth.enable {
     hardware.bluetooth.enable = true;
  };

}
