{ lib, stdenvNoCC, fetchurl, p7zip, symlinkJoin }:

let
  version = "10.0.26100.1742";

  isoUrl = "https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/26100.1742.240906-0331.ge_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso";
  isoSha256 = "74d696e666f696e93db685a85c94bfbfcc0796dfcf8a2e2e2e2c908a54e82949";

  coreFonts = [
    "arial.ttf" "arialbd.ttf" "ariali.ttf" "arialbi.ttf"
    "ariblk.ttf"
    "bahnschrift.ttf"
    "calibri.ttf" "calibrib.ttf" "calibrii.ttf" "calibriz.ttf"
    "calibril.ttf" "calibrili.ttf"
    "cambria.ttc" "cambriab.ttf" "cambriai.ttf" "cambriaz.ttf"
    "Candara.ttf" "Candarab.ttf" "Candarai.ttf" "Candaraz.ttf"
    "Candaral.ttf" "Candarali.ttf"
    "comic.ttf" "comicbd.ttf" "comici.ttf" "comicz.ttf"
    "consola.ttf" "consolab.ttf" "consolai.ttf" "consolaz.ttf"
    "constan.ttf" "constanb.ttf" "constani.ttf" "constanz.ttf"
    "corbel.ttf" "corbelb.ttf" "corbeli.ttf" "corbelz.ttf"
    "corbell.ttf" "corbelli.ttf"
    "cour.ttf" "courbd.ttf" "couri.ttf" "courbi.ttf"
    "framd.ttf" "framdit.ttf"
    "Gabriola.ttf"
    "georgia.ttf" "georgiab.ttf" "georgiai.ttf" "georgiaz.ttf"
    "impact.ttf"
    "Inkfree.ttf"
    "l_10646.ttf"
    "lucon.ttf"
    "marlett.ttf"
    "micross.ttf"
    "pala.ttf" "palab.ttf" "palai.ttf" "palabi.ttf"
    "segmdl2.ttf"
    "SegoeIcons.ttf"
    "segoepr.ttf" "segoeprb.ttf"
    "segoesc.ttf" "segoescb.ttf"
    "segoeui.ttf" "segoeuib.ttf" "segoeuii.ttf" "segoeuiz.ttf"
    "segoeuil.ttf" "seguili.ttf"
    "segoeuisl.ttf" "seguisli.ttf"
    "seguibl.ttf" "seguibli.ttf"
    "seguiemj.ttf"
    "seguihis.ttf"
    "seguisb.ttf" "seguisbi.ttf"
    "seguisym.ttf"
    "SegUIVar.ttf"
    "SitkaVF.ttf" "SitkaVF-Italic.ttf"
    "sylfaen.ttf"
    "symbol.ttf"
    "tahoma.ttf" "tahomabd.ttf"
    "times.ttf" "timesbd.ttf" "timesi.ttf" "timesbi.ttf"
    "trebuc.ttf" "trebucbd.ttf" "trebucit.ttf" "trebucbi.ttf"
    "verdana.ttf" "verdanab.ttf" "verdanai.ttf" "verdanaz.ttf"
    "webdings.ttf"
    "wingding.ttf"
  ];

  japaneseFonts = [
    "msgothic.ttc"
    "YuGothR.ttc" "YuGothB.ttc"
    "YuGothM.ttc"
    "YuGothL.ttc"
  ];

  koreanFonts = [
    "malgun.ttf" "malgunbd.ttf"
    "malgunsl.ttf"
  ];

  seaFonts = [
    "javatext.ttf"
    "himalaya.ttf"
    "ntailu.ttf" "ntailub.ttf"
    "phagspa.ttf" "phagspab.ttf"
    "taile.ttf" "taileb.ttf"
    "msyi.ttf"
    "monbaiti.ttf"
    "mmrtext.ttf" "mmrtextb.ttf"
    "Nirmala.ttc"
  ];

  thaiFonts = [
    "LeelawUI.ttf" "LeelaUIb.ttf"
    "LeelUIsl.ttf"
  ];

  zhCnFonts = [
    "simsun.ttc"
    "simsunb.ttf"
    "msyh.ttc" "msyhbd.ttc"
    "msyhl.ttc"
  ];

  zhTwFonts = [
    "msjh.ttc" "msjhbd.ttc"
    "msjhl.ttc"
    "mingliub.ttc"
  ];

  otherFonts = [
    "ebrima.ttf" "ebrimabd.ttf"
    "gadugi.ttf" "gadugib.ttf"
    "mvboli.ttf"
  ];

  extractedFonts = stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "ms-win11-fonts-src";
    inherit version;

    src = fetchurl {
      url = isoUrl;
      sha256 = isoSha256;
    };

    nativeBuildInputs = [ p7zip ];
    dontUnpack = true;
    dontConfigure = true;
    dontFixup = true;

    buildPhase = ''
      runHook preBuild

      mkdir -p iso extracted

      7z e -y -oiso "$src" sources/install.wim
      7z e -y -oextracted iso/install.wim \
        "Windows/Fonts/*.ttf" \
        "Windows/Fonts/*.ttc" \
        "Windows/System32/Licenses/neutral/*/*/license.rtf"

      test -f extracted/license.rtf

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p "$out"
      cp -v extracted/* "$out/"
      runHook postInstall
    '';

    preferLocalBuild = true;
    allowSubstitutes = false;

    meta = {
      description = "Extracted Microsoft Windows 11 font payload";
      license = lib.licenses.unfree;
      platforms = lib.platforms.all;
    };
  });

  mkFontPackage = {
    pname,
    description,
    files,
  }:
    stdenvNoCC.mkDerivation {
      inherit pname version;
      src = extractedFonts;

      dontUnpack = true;
      dontConfigure = true;

      installPhase = let
        escapedFiles = lib.escapeShellArgs files;
      in ''
        runHook preInstall

        install -d "$out/share/fonts/truetype"
        for f in ${escapedFiles}; do
          install -m444 "$src/$f" "$out/share/fonts/truetype/$f"
        done

        install -d "$out/share/licenses/$pname"
        install -m444 "$src/license.rtf" "$out/share/licenses/$pname/license.rtf"

        runHook postInstall
      '';

      preferLocalBuild = true;
      allowSubstitutes = false;

      meta = {
        inherit description;
        homepage = "https://www.microsoft.com/typography/fonts/product.aspx?PID=164";
        license = lib.licenses.unfree;
        platforms = lib.platforms.all;
      };
    };

  packages = rec {
    ttf-ms-win11-auto = mkFontPackage {
      pname = "ttf-ms-win11-auto";
      description = "Microsoft Windows 11 TrueType fonts";
      files = coreFonts;
    };

    ttf-ms-win11-auto-japanese = mkFontPackage {
      pname = "ttf-ms-win11-auto-japanese";
      description = "Microsoft Windows 11 Japanese TrueType fonts";
      files = japaneseFonts;
    };

    ttf-ms-win11-auto-korean = mkFontPackage {
      pname = "ttf-ms-win11-auto-korean";
      description = "Microsoft Windows 11 Korean TrueType fonts";
      files = koreanFonts;
    };

    ttf-ms-win11-auto-sea = mkFontPackage {
      pname = "ttf-ms-win11-auto-sea";
      description = "Microsoft Windows 11 Southeast Asian TrueType fonts";
      files = seaFonts;
    };

    ttf-ms-win11-auto-thai = mkFontPackage {
      pname = "ttf-ms-win11-auto-thai";
      description = "Microsoft Windows 11 Thai TrueType fonts";
      files = thaiFonts;
    };

    ttf-ms-win11-auto-zh_cn = mkFontPackage {
      pname = "ttf-ms-win11-auto-zh_cn";
      description = "Microsoft Windows 11 Simplified Chinese TrueType fonts";
      files = zhCnFonts;
    };

    ttf-ms-win11-auto-zh_tw = mkFontPackage {
      pname = "ttf-ms-win11-auto-zh_tw";
      description = "Microsoft Windows 11 Traditional Chinese TrueType fonts";
      files = zhTwFonts;
    };

    ttf-ms-win11-auto-other = mkFontPackage {
      pname = "ttf-ms-win11-auto-other";
      description = "Microsoft Windows 11 Other TrueType fonts";
      files = otherFonts;
    };

    ttf-ms-win11-auto-all = symlinkJoin {
      name = "ttf-ms-win11-auto-all-${version}";
      paths = [
        ttf-ms-win11-auto
        ttf-ms-win11-auto-japanese
        ttf-ms-win11-auto-korean
        ttf-ms-win11-auto-sea
        ttf-ms-win11-auto-thai
        ttf-ms-win11-auto-zh_cn
        ttf-ms-win11-auto-zh_tw
        ttf-ms-win11-auto-other
      ];
      meta = {
        description = "All Microsoft Windows 11 font subsets extracted from the evaluation ISO";
        homepage = "https://www.microsoft.com/typography/fonts/product.aspx?PID=164";
        license = lib.licenses.unfree;
        platforms = lib.platforms.all;
      };
    };
  };
in
packages
