{ pkgs, lib, config, ... }: {
  
  options = {
    steam.enable = lib.mkEnableOption "Enables Steam Module";
  };

  config = lib.mkIf config.steam.enable {
    programs.steam = {
      enable = true;
      extraCompatPackages = 
        with pkgs; [
          proton-ge-bin
        ];
      remotePlay.openFirewall = true; # Steam Play
      extraPackages = [ pkgs.gamescope ];
      extest.enable = true; # Enables Steam Input on Wayland
    }; 
  };

}
