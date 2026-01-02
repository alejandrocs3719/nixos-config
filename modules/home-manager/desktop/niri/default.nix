{ pkgs, lib, config, inputs, ... }:

let
  cfg = config.modules.desktop.niri;
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  confPath = "${config.home.homeDirectory}/.nixos-config/modules/home-manager/desktop/niri/config";
in {
  options.modules.desktop.niri.enable = lib.mkEnableOption "Enables my Niri configuration";

  imports = [
  ];

  config = lib.mkIf cfg.enable {

    # mkOutOfStoreSymlink when this module in enabled
    xdg.configFile."niri" = {
      source = create_symlink "${confPath}";
      recursive = true;
    };

    # Idle daemon:
    services.swayidle = {
      enable = true;
      timeouts = [
        # 2 min: DPMS off
        {
          timeout = 120;
          command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
        }
        # 5 min: lock
        {
          timeout = 20;
          command = "${inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/noctalia-shell ipc call lockScreen lock";
        }
        # 15 min: suspend
        {
          timeout = 25;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };

    # Polkit
    services.polkit-gnome.enable = true;

    
  };
}

