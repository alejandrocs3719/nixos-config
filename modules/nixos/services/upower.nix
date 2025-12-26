{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{

  options = {
    battery.tuned.enable = lib.mkEnableOption "Enables TuneD for power management";
  };

  config = lib.mkIf config.battery.tuned.enable {
    services.tuned = {
      enable = true;
	    # settings.dynamic_tuning = true;
    };
  };

}
