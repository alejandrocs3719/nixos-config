{ pkgs, lib, config, ... }:

let
  cfg = config.modules.networking.sunshine;
in {
  options.modules.networking.sunshine.enable = lib.mkEnableOption "Enables Sunshine server";

  imports = [
  
  ];

  config = lib.mkIf cfg.enable {

    services.sunshine = {
      enable = true;
      autoStart = false; # false by default, may turn in on in main pc
      capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
      openFirewall = true;
      settings = {
        # pc  - Only localhost may access the web ui
        # lan - Only LAN devices may access the web ui
        origin_web_ui_allowed = "pc";
        # 2   -	encryption is mandatory and unencrypted connections are rejected
        lan_encryption_mode = 2;
        wan_encryption_mode = 2;
      };

    #   applications = {
    #     apps = [

          
    #       {
    #         name = "Steam Gamescope 2388x1668 120Hz VRR";

    #         # Gamescope + Steam Big Picture
    #         cmd =
    #           "gamescope -W 2388 -H 1668 -r 120 -f --adaptive-sync --hdr-enabled -- gamemoderun steam -tenfoot";

    #         # Turn off/on internal laptop display (OLED protection)
    #         prep-cmd = [
    #           {
    #             do = "niri msg output eDP-1 off";
    #             undo = "niri msg output eDP-1 on";
    #           }
    #         ];

    #         auto-detach = "false";
    #         exclude-global-prep-cmd = "false";
    #       }
    #     ];
    #   };
    };

  };
}

