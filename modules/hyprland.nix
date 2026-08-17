{ config, pkgs, ... }:

{

  home.packages = with pkgs; [];
  
  xdg.configFile."hypr/hyprland.conf" = {
    source = ../configs/hyprland.conf;
  };
}
