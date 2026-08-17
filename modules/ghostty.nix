{ config, pkgs, ... }:

let
  theme = "catppuccin_mocha";
in {
  home.packages = with pkgs; [ ghostty ];
  xdg.configFile."ghostty".source = ../configs/ghostty;
}
