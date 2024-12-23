{
  pkgs,
  dpkg,
  autoPatchelfHook,
  libsForQt5,
  qt5,
  ...
}: let
  aftershot = pkgs.stdenv.mkDerivation {
    pname = "aftershot-pro";
    version = "3.7.0.446";

    src = pkgs.fetchurl {
      url = "https://dwnld.aftershotpro.com/trials/3/AfterShotPro3-system-QT.deb";
      sha256 = "sha256-FtWOALHbm9F/kVSWZB3EDm/rSKPmml4up/Zcl6tzPy4=";
    };

    buildInputs = [
      qt5.qtbase
      qt5.qtwebkit
      libsForQt5.kdesignerplugin
    ];

    nativeBuildInputs = [
      dpkg
      qt5.wrapQtAppsHook
      autoPatchelfHook
    ];
    unpackPhase = ''
      dpkg-deb -x $src ./
    '';
    installPhase = ''
      mkdir -p $out
      mv ./opt/AfterShot*/* $out/
      mv $out/bin $out/libexec

      mkdir -p $out/bin

      cat > $out/bin/AfterShot <<EOF
      #!/usr/bin/env bash

      cd $out/libexec/
      ./AfterShot $@
      EOF

      chmod a+x $out/bin/AfterShot
    '';
  };
in
  aftershot
