{
  pkgs,
  lib,
  config,
  ...
}:
{

  #  options = {
  #graphics.nvidia.enable = lib.mkEnableOption "Enables Nvidia Graphics Module (and Intel Graphics too)";
  #};

  #config = lib.mkIf config.graphics.nvidia.enable {
  nixpkgs.config.allowUnfree = true;
  # Nvidia Drivers with prime offloading and power management features:
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [
    "nvidia"
  ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true; # nvidia-drm.modeset=1
  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  hardware.nvidia.powerManagement = {
    enable = true; # hibernate, suspend and resume systemctl services
    finegrained = true; # options nvidia "NVreg_DynamicPowerManagement=0x02", nvidia.rules from asus-linux
  };
  hardware.nvidia.dynamicBoost.enable = true; # nvidia-powerd

  # Asus Linux https://gitlab.com/asus-linux/nvidia-laptop-power-cfg/-/blob/main/nvidia.conf?ref_type=heads
  boot.extraModprobeConfig = ''
    options nvidia NVreg_EnableS0ixPowerManagement=1
  '';
  #};

}
