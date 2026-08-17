{config, pkgs, ...}:

{
  home.packages = with pkgs; [
    hyprpaper
  ];

  xdg.configFile."hypr/wallpapers" = {
    source = ../wallpapers;
  };

  xdg.configFile."hypr/hyprpaper.conf" = {
    source = ../configs/hyprpaper.conf;
  };
}
