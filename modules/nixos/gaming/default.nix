{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.modules.gaming;
in {
  options.modules.gaming.enable = lib.mkEnableOption "Installs and configures game launchers";

  imports = [

  ];

  config = lib.mkIf cfg.enable {

    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      remotePlay.openFirewall = true; # Steam Link
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
      extraPackages = [ pkgs.gamescope ];
      extest.enable = true; # Enables Steam Input on Wayland
      platformOptimizations.enable = true; # needs nix-gaming: fixes Fallout 76 (splitlock mitigate)

    };


    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      steam-devices-udev-rules
      gamescope
      gamemode
      mangohud
      steam-run
      lutris
      bottles
      heroic
    ];

  };
}
