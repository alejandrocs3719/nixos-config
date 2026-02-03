{
  config,
  pkgs,
  hostName,
  ...
}:
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
  #programs.bash = {
  #enable = true;
  #initExtra = ''
  # One line prompt (arregla lo de .venv arriba)
  #   PS1='\[\033[1;32m\][\u@\h:\w]\$\[\033[0m\] '
  #'';
  #};
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      nrs = "sudo nixos-rebuild switch --flake /home/${config.home.username}/.nixos-config#${hostName}";
    };

    history.size = 100000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = [
      "rm *"
      "pkill *"
      "cp *"
    ];

    initContent = ''

                      # Colores en escala de grises
                      MAT_SURFACE="#212121"      # fondo oscuro (hora + banner)
                      MAT_PRIMARY="#424242"      # usuario
                      MAT_SECONDARY="#616161"    # directorio

                      MAT_ON_SURFACE="#ffffff"   # texto sobre SURFACE
                      MAT_ON_PRIMARY="#ffffff"   # texto sobre PRIMARY
                      MAT_ON_SECONDARY="#ffffff" # texto sobre SECONDARY

                      MAT_TERTIARY="#ffffff"     # texto blanco extra

                      # prompt
                      NEWLINE=$'\n'

                      PROMPT="''${NEWLINE}\
                  %K{$MAT_SURFACE}%F{$MAT_ON_SURFACE}$(date +%H:%M) \
                  %K{$MAT_PRIMARY}%F{$MAT_ON_PRIMARY} %n \
                  %K{$MAT_SECONDARY}%F{$MAT_ON_SECONDARY} %~ \
                  %f%k %F{$MAT_PRIMARY}❯%f "

                      print -P "''${NEWLINE}\
                  %K{$MAT_SURFACE}\
                  %F{$MAT_SECONDARY} it's %D{%_I:%M%P} \
                  %F{$MAT_ON_SURFACE}$(uname -r) \
                  %f%k"
    '';
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
    brave
    kdePackages.kdenlive # Video editor
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
    ];
  };

  modules.gaming.enable = true;
  modules.dev.enable = true;
  modules.virtualisation.enable = true;
  modules.theming.gtk.enable = true;

  # home.wl-sunset.enable = true;
  modules.desktop.hyprland = {
    enable = true;
    #   stylixColors = true;
  };
  #modules.desktop.niri.enable = true;
  # modules.desktop.niri.enable = true;
  # home.swayosd.enable = false;
  home.yazi.enable = true;
  home.libreoffice.enable = true;
  home.onlyoffice.enable = true;
  home.swaync.enable = false;
  home.alacritty.enable = true;
  home.kanshi.enable = false;
  #home.gtk.enable = true;
}
