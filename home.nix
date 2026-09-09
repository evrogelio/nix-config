{ config, pkgs, inputs, ... }:
{
  home.username = "rogelioev";
  home.homeDirectory = "/home/rogelioev";
  home.stateVersion = "25.05";
  
  programs.home-manager.enable = true;
}
