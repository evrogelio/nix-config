{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      # This ensures it targets the session correctly
      target = "graphical-session.target"; 
    };
  };

  systemd.user.services.waybar = {
    Unit = {
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
      RestartSec = "2s";
      Environment = lib.mkForce "PATH=${lib.makeBinPath [ pkgs.waybar pkgs.hyprland ]}";
    };
    Install = {
      WantedBy = [ "default.target" ]; 
    };
  };

  xdg.configFile."waybar/config".source = ../configs/waybar-config.jsonc;
  xdg.configFile."waybar/style.css".source = ../configs/waybar-style.css;
}
