{ pkgs, lib, config, ... }:

let
  cfg = config.graphics.nvidia;
in {
  options.graphics.nvidia.enable = lib.mkEnableOption "Enables Nvidia graphics card configuration";

  imports = [
    ./nvidia.nix
    ./specialisations.nix
  ];

  config = lib.mkIf cfg.enable {
  };
}

