{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/.nixos-config/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    #    hypr = "hypr";
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

  home.stylix.enable = true;
  home.wl-sunset.enable = true;
  desktop.hyprland.enable = true;
  home.swayosd.enable = true;
  home.yazi.enable = true;
  home.libreoffice.enable = true;
  home.onlyoffice.enable = true;
  home.swaync.enable = true;
  # xresources.extraConfig = ''
  #   Xft.antialias: true
  #   Xft.hinting:   true
  #   Xft.rgba:      rgb
  #   Xft.hintstyle: hintfull
  #   Xft.dpi:       120
  # '';

}
