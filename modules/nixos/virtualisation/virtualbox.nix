{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    modules.virtualisation.virtualbox.enable = lib.mkEnableOption "Enables VirtualBox";
  };

  config = lib.mkIf config.modules.virtualisation.virtualbox.enable {

    nixpkgs.config.allowUnfree = true;
    virtualisation.virtualbox.host = {
      enable = true;
      enableKvm = true; # KVM hypervisor
      addNetworkInterface = false;
      enableExtensionPack = true;
    };
    users.extraGroups.vboxusers.members = [ "alejandro" ]; # TODO: make username a variable.
  };
}
