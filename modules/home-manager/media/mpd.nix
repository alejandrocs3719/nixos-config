{
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    modules.media.mpd.enable = lib.mkEnableOption "Installs MPD with mpris compatibility and playerctl";
  };

  config = lib.mkIf config.home.libreoffice.enable {

    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/music";
      playlistDirectory = "${config.xdg.dataHome}/mpd/playlists";
    };
    
    services.playerctld.enable = true;

    services.mpd-mpris.enable = true;

    home.packages = with pkgs; [
      playerctl
      ncmpcpp
    ];

  };

}
