{ pkgs, lib, config, ... }:

let
  cfg = config.modules.virtualisation;
in {
  options.modules.virtualisation.enable = lib.mkEnableOption "Enables Virtualisation";

  imports = [
    ./podman.nix
    ./virtualbox.nix
  ];

  config = lib.mkIf cfg.enable {
  };
}
