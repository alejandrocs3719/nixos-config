{ pkgs, lib, ... }: {

  imports = [
    ./desktop/kanshi.nix
    # ./desktop/stylix.nix
    ./desktop/kde-plasma/plasma.nix
  ];

}
 
 
