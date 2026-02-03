{ pkgs, lib, config, ... }:

let
  cfg = config.modules.graphics.nvidia;
in {
  options.modules.graphics.nvidia.enable = lib.mkEnableOption "Enables Nvidia graphics card configuration";

  imports = [
    ./nvidia.nix
    ./specialisations.nix
  ];

  config = lib.mkIf cfg.enable {
  };
}

