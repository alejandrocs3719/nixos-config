{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [ 
    protonplus # GUI for installing custom Proton versions like GE_Proton
    winetricks # Script to install various redistributable runtime libraries in Wine.
    umu-launcher # unified launcher for Windows games in Linux
    moonlight-qt # sunshine game streaming client
  ];
}
