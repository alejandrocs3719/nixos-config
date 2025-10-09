{ config, pkgs, ... }:
let 
  dotfiles = "${config.home.homeDirectory}/.nixos-config/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  
  configs = {
    hypr = "hypr";
    nvim = "nvim";
    alacritty = "alacritty";
    rofi = "rofi";
    waybar = "waybar";

  };

in

{
    home.username = "alejandro";
    home.homeDirectory = "/home/alejandro";
    home.stateVersion = "25.05";
    programs.zsh = {
        enable = true;
        shellAliases = {
            btw = "echo i use nix btw";
        };
    };
  


    # Loop to prevent code duplication
    xdg.configFile = builtins.mapAttrs (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
      	
    }) configs;

 
  # xdg.configFile."hypr" = {
  #     source = create_symlink "${dotfiles}/hypr";
  #     recursive = true;
  # };
  #
  # xdg.configFile."nvim" = {
  #     source = create_symlink "${dotfiles}/nvim";
  #     recursive = true;
  # };

  # xdg.configFile."alacritty" = {
  #     source = create_symlink "${dotfiles}/alacritty";
  #     recursive = true;
  # };

    home.packages = with pkgs; [
	neovim
	ripgrep
	nil # LSP for Nix
	nixpkgs-fmt
	nodejs
	gcc
        fastfetch
    ];
    
    # Night mode
    services.wlsunset = {
	enable = true;
	latitude = 40.4165; 
	longitude = -3.70256;
	temperature.night = 1000;
    };


  # xresources.extraConfig = ''
  #   Xft.antialias: true
  #   Xft.hinting:   true
  #   Xft.rgba:      rgb
  #   Xft.hintstyle: hintfull
  #   Xft.dpi:       120
  # '';

}
