{ config, pkgs, lib, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 300; # Shorter height feels more like Spotlight
      location = "center";
      show = "drun";
      prompt = "Search";
      filter_rate = 100;
      allow_images = true;
      image_size = 24;
      # This hides the search icon and line if you want it super minimal
      no_actions = true;
      halign = "fill";
    };
  };

  xdg.configFile."wofi/style.css".source = ../configs/wofi-style.css;

}
