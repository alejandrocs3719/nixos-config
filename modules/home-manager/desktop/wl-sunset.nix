{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    home.wl-sunset.enable = lib.mkEnableOption "Enables wl-sunset";
  };

  config = lib.mkIf config.home.wl-sunset.enable {

    # Night mode
    services.wlsunset = {
      enable = true;
      latitude = 40.4165;
      longitude = -3.70256;
      temperature.night = 1000;
    };
  };

}
