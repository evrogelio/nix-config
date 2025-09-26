{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
  ];

  xdg.configFile."waybar/config".source = ../configs/waybar-config.jsonc;
  xdg.configFile."waybar/style.css".source = ../configs/waybar-style.css;
}

