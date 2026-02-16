{ pkgs, lib, config, ... }: {
  
  options = {
    modules.virtualisation.virtualbox.enable = lib.mkEnableOption "Enables VirtualBox";
  };

  config = lib.mkIf config.modules.virtualisation.virtualbox.enable {
     virtualisation.virtualbox.host = {
	enable = true;
	enableKvm = true; # KVM hypervisor
	addNetworkInterface = false;
     };
     users.extraGroups.vboxusers.members = [ "alejandro" ]; # TODO: make username a variable.
  };
}
