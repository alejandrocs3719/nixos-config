{ pkgs, lib, config, ... }: {
  
  options = {
    graphics.nvidia.enable = lib.mkEnableOption "Enables Nvidia Graphics Module (and Intel Graphics too)";
	
  };

  config = lib.mkIf config.graphics.nvidia.enable {
     
    # Richard Stallman is crying:
      nixpkgs.config.allowUnfree = true;
    # Nvidia Drivers with prime offloading:
      hardware.graphics.enable = true;
      services.xserver.videoDrivers = [
        "modesetting" 
        "nvidia"
      ];  
      hardware.nvidia.open = true; 
      hardware.nvidia.modesetting.enable = true;
      hardware.nvidia.prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      hardware.nvidia.powerManagement = {
        enable = true;
        finegrained = true;
      };

  };

}
