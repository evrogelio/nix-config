{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  
  xdg.configFile."hypr/hyprland.conf" = {
    source = ../configs/hyprland.conf;
  };
}
