{ pkgs, lib, config, ... }:

let
  cfg = config.modules.gaming;
in {
  options.modules.gaming.enable = lib.mkEnableOption "Installs and configures game launchers";

  imports = [
    ./lutris.nix
    ./heroic.nix
    ./packages.nix
    ./prismlauncher.nix
  ];

  config = lib.mkIf cfg.enable {
  };
}
