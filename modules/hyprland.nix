{ config, pkgs, ... }:

let
  wallpapersDir = ../wallpapers;
in {

  home.packages = with pkgs; [
    hyprpaper
  ];
  
  # Symlink your hyprland.conf from your flake repo
  xdg.configFile."hypr/hyprland.conf" = {
    source = ../configs/hyprland.conf; # keep this file alongside hyprland.nix
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${wallpapersDir}/forest.jpg
    wallpaper = eDP-1,${wallpapersDir}/bg1.jpg
  '';
}

