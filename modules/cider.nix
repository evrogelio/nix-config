{ pkgs, ... }:

let
  cider-2 = pkgs.stdenv.mkDerivation rec {
    pname = "cider-2";
    version = "3.1.8";

    src = ../binaries/cider.deb;

    nativeBuildInputs = with pkgs; [
      dpkg
      autoPatchelfHook
      makeWrapper
    ];

    buildInputs = with pkgs; [
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      dbus
      expat
      fontconfig
      freetype
      gdk-pixbuf
      glib
      gtk3
      libdrm
      libglvnd
      libnotify
      libpulseaudio
      libuuid
      libxkbcommon
      mesa
      nspr
      nss
      pango
      systemd
      libsecret
      libxcrypt-legacy
      xorg.libX11
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXtst
      xorg.libxcb
      xorg.libxshmfence
    ];

    unpackPhase = "dpkg-deb -x $src .";

    installPhase = ''
      mkdir -p $out/bin
      cp -r usr/share $out/share
      cp -r opt/Cider/cider $out/bin/cider
      
      # Fix the icon and path in the desktop file
      substituteInPlace $out/share/applications/cider.desktop \
        --replace "/opt/Cider/cider" "$out/bin/cider"
    '';
  };
in
{
  home.packages = [ cider-2 ];
  
}
