{ pkgs, lib, config, ... }:

let
  cfg = config.modules.virtualisation;
in {
  options.modules.virtualisation.enable = lib.mkEnableOption "Installs and configures virtualisation utilities";

  imports = [
    ./distrobox.nix
  ];

  config = lib.mkIf cfg.enable {
  };
}
