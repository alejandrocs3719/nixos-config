{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    modules.desktop.wl-sunset.enable = lib.mkEnableOption "Enables wl-sunset";
  };

  config = lib.mkIf config.modules.desktop.wl-sunset.enable {

    # Night mode
    services.wlsunset = {
      enable = true;
      latitude = 40.4165;
      longitude = -3.70256;
      temperature.night = 1000;
    };
  };

}
