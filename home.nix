{ config, pkgs, inputs, ... }:
{
  home.username = "rogelioev";
  home.homeDirectory = "/home/rogelioev";
  home.stateVersion = "25.05";
  
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
