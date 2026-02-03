final: prev:

let
  pname = "bibata-modern-classic-hyprcursor";
  version = "latest";
in
{
  bibata-modern-classic-hyprcursor = prev.stdenvNoCC.mkDerivation {
    inherit pname version;

    src = prev.fetchzip {
      url = "https://github.com/LOSEARDES77/Bibata-Cursor-hyprcursor/releases/latest/download/hypr_Bibata-Modern-Classic.tar.gz";
      sha256 = "sha256-Uv+96EieGBq6cJNWjoJEHPy/MshbHts+OBow7rWgBSM=";
      stripRoot = false;
    };

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/icons/Bibata-Modern-Classic
      cp -r * $out/share/icons/Bibata-Modern-Classic/

      runHook postInstall
    '';

    meta = with prev.lib; {
      description = "Bibata Modern Classic hyprcursor theme";
      platforms = platforms.linux;
    };
  };
}

