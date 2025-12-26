self: super: {
  mcmojave-cursors = super.stdenv.mkDerivation rec {
    pname = "McMojave-cursors";
    version = "2021-02-24";

    src = super.fetchFromGitHub {
      owner = "vinceliuice";
      repo = "McMojave-cursors";
      rev = "7d0bfc1f91028191cdc220b87fd335a235ee4439";
      sha256 = "sha256-4YqSucpxA7jsuJ9aADjJfKRPgPR89oq2l0T1N28+GV0="; # por calcular
    };

    nativeBuildInputs = [ super.bash ];

    installPhase = ''
      mkdir -p $out/share/icons/McMojave-cursors
      cp -pr dist/* $out/share/icons/McMojave-cursors/
    '';

    meta = with super.lib; {
      description = "Cursors inspired by macOS Mojave";
      homepage = "https://github.com/vinceliuice/McMojave-cursors";
      license = licenses.gpl3;
      platforms = platforms.linux;
    };
  };
}

