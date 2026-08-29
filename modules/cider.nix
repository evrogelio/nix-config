{ pkgs, ... }:
let
  cider-2 = pkgs.stdenv.mkDerivation rec {
    pname = "cider-2";
    version = "3.1.8";

    src = pkgs.requireFile {
      name = "cider.deb";
      sha256 = "0a2lmn042ddc4pf8szksj64y659cw4rqbbv9jv22q4fjh1b592vi";
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
      # Wrap the REAL binary from the lib folder and place the wrapper in bin/cider
      # Note the capital 'C' in the source path from your logs
      makeWrapper $out/lib/cider/Cider $out/bin/cider \
        --add-flags "--no-sandbox" \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}"
        
      # Fix the desktop file to use our lowercase 'cider' wrapper
      substituteInPlace $out/share/applications/cider.desktop \
        --replace "/usr/bin/cider" "cider"
    '';
  };
in
{
  home.packages = [ cider-2 ];
}
