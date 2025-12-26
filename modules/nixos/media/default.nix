{ pkgs, lib, config, ... }:

let
  cfg = config.modules.media;
in {
  options.modules.media.enable = lib.mkEnableOption "Enables media programs (audio, video, images, pdf)";

  imports = [
    ./audio.nix
    ./video.nix
    ./pdf.nix
    ./image.nix
  ];

  config = lib.mkIf cfg.enable {
  };
}
