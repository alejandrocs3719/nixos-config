{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{

  options = {
    battery.power-profiles-daemon.enable = lib.mkEnableOption "Enables Power Profiles Daemon for power management";
  };

  config = lib.mkIf config.battery.power-profiles-daemon.enable {
    services.power-profiles-daemon.enable = true; 
  };


}
