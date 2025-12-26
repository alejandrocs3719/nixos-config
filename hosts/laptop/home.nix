{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/.nixos-config/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    # hypr = "hypr";
    nvim = "nvim";
    # alacritty = "alacritty";
    # rofi = "rofi";
    #   waybar = "waybar";

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
    impala # TUI connections manager
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
    ];
  };

  modules.gaming.enable = true;
  modules.desktop.niri.enable = true;
  modules.theming.stylix.enable = true;
  home.rofi.enable = false;
  # home.wl-sunset.enable = true;
  desktop.hyprland.enable = false;
  # home.swayosd.enable = false;
  home.yazi.enable = true;
  home.libreoffice.enable = false;
  home.onlyoffice.enable = false;
  home.swaync.enable = false;
  home.waybar.enable = false;
  home.alacritty.enable = true;
  home.kanshi.enable = true;
  #home.gtk.enable = true;
}
