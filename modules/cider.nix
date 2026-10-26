{ pkgs, ... }:
let
  cider-2 = pkgs.stdenv.mkDerivation rec {
    pname = "cider-2";
    version = "3.1.8";

    src = pkgs.requireFile {
      name = "cider.deb";
      sha256 = "15aw2k82y9j8qm0xrcsly5mc97j82lig2zxa32j66xdj9i5yka89";
      message = ''
        Download the cider.deb file from the official source and place it in the Nix store. You can use the following command to download it:
          nix-store --add-fixed sha256 /path/to/cider.deb
      '';
    };

    nativeBuildInputs = with pkgs; [
      binutils
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

    unpackPhase = ''
      ar x $src
      tar -xvf data.tar.zst || tar -xvf data.tar.xz
    '';

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/lib/cider
      
      cp -r usr/share $out/share
      cp -r usr/lib/cider/* $out/lib/cider/

      # We don't symlink yet, we wrap the actual binary into $out/bin
    '';

    postFixup = ''
      makeWrapper $out/lib/cider/Cider $out/bin/cider \
        --add-flags "--no-sandbox --ozone-platform=x11" \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}"
        
      substituteInPlace $out/share/applications/cider.desktop \
        --replace "/usr/bin/cider" "cider"
    '';
  };
in
{
  home.packages = [ cider-2 ];
}
