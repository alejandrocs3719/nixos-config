{
  pkgs,
  lib,
  config,
  ...
}:
{

programs.zathura = {
  enable = true;
  options = {
    selection-clipboard = "clipboard"; # use system clipboard

  };
};


}
