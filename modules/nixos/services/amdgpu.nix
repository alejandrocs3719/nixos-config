{ pkgs, lib, config, ... }: {
  
  options = {
    graphics.amd.enable = lib.mkEnableOption "Enables Nvidia Graphics Module (and Intel Graphics too)";
  };

  config = lib.mkIf config.graphics.amd.enable {
     hardware.graphics = {
      enable = true;
      enable32Bit = true;
     };
  };
}
