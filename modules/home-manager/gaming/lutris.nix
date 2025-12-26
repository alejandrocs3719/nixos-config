{ pkgs, config, osConfig, ... }:

{

  programs.lutris = {
    enable = true;
    defaultWinePackage = pkgs.proton-ge-bin;
    steamPackage = osConfig.programs.steam.package;
    protonPackages = [ pkgs.proton-ge-bin ];
    winePackages = with pkgs; [
      wineWow64Packages.full
      wineWowPackages.stagingFull
    ];
    extraPackages = with pkgs; [
      winetricks
      gamescope
      gamemode
      mangohud
      umu-launcher
    ];
  };

}
