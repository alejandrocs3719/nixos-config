{ pkgs, lib, config, ... }: {
  
  options = {
    modules.graphics.amd.enable = lib.mkEnableOption "Enables Nvidia Graphics Module (and Intel Graphics too)";
  };

  config = lib.mkIf config.modules.graphics.amd.enable {
     # 3D Acceleration
     hardware.graphics = {
      enable = true;
      enable32Bit = true;
     };

     # Fixes low resolution during initramfs phase
     hardware.amdgpu.initrd.enable = true; # sets boot.initrd.kernelModules = ["amdgpu"];
  };
}
