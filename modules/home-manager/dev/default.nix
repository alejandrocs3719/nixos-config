{ pkgs, lib, config, ... }:

let
  cfg = config.modules.dev;
in {
  options.modules.dev.enable = lib.mkEnableOption "Installs dev tools";

  imports = [
    ./direnv.nix
  ];

  config = lib.mkIf cfg.enable {
  };
}
