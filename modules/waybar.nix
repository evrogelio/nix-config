
{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
  };

  xdg.configFile."waybar/config".source = ../configs/waybar-config.jsonc;
  xdg.configFile."waybar/style.css".source = ../configs/waybar-styles.css;

}
