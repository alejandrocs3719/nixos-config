{ pkgs, lib, config, ... }: {
  
  options = {
    modules.services.ddcutil.enable = lib.mkEnableOption "Enables ddcutil and i2c in order to control external monitor options";
  };

  config = lib.mkIf config.modules.services.ddcutil.enable {
    hardware.i2c.enable = true;

    environment.systemPackages = with pkgs; [
      i2c-tools # i2c communication protocol
      ddcutil # Provides the ability to change monitor settings
    ];
    
    users.users.alejandro.extraGroups = [ "i2c" ]; # Adds user to group i2c so i don't need root access

  };
}
