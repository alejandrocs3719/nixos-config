{
  pkgs,
  lib,
  config,
  ...
}:
{
  specialisation.discrete-gpu.configuration = {
    system.nixos.tags = [ "discrete-gpu" ];
    hardware.nvidia.prime = {
      offload = {
        enable = lib.mkForce false;
        enableOffloadCmd = lib.mkForce false;
      };
      reverseSync.enable = lib.mkForce true;
    };
    hardware.nvidia.powerManagement = {
      enable = lib.mkForce false; # This option requires offload enabled
      finegrained = lib.mkForce false;
    };
  };

  specialisation.integrated.configuration = {
    system.nixos.tags = [ "integrated" ];

    imports = [
      ./disable-nvidia.nix
    ];

    hardware.nvidia.prime = {
      offload = {
        enable = lib.mkForce false;
        enableOffloadCmd = lib.mkForce false;
      };
      reverseSync.enable = lib.mkForce false;
    };
    hardware.nvidia.powerManagement = {
      enable = lib.mkForce false; # This option requires offload enabled
      finegrained = lib.mkForce false;
    };
    hardware.nvidia.dynamicBoost.enable = true;
  };

}
