{ config, pkgs, lib, ... }:

{
  # Install wlogout
  home.packages = with pkgs; [
    wlogout
  ];

  # Configure layout (actions shown in the menu)
  xdg.configFile."wlogout/layout".source = ../configs/wlogout/layout;

  xdg.configFile."wlogout/style.css".text = lib.replaceStrings
    [ "$HOME" ]
    [ config.home.homeDirectory ]
    (builtins.readFile ../configs/wlogout/style.css);

  xdg.configFile."wlogout/icons".source = ../configs/wlogout/icons;

}

