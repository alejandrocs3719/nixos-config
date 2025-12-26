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
    };

  };
}

