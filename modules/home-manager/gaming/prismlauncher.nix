{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (prismlauncher.override {
        jdks = with pkgs; [
          temurin-bin-8 # TODO: Maybe replace when `jdk8` isn't broken
          jdk17
          jdk21
        ];
      })
  ];
}
