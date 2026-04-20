{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";
  };

  systemd.user.services.waybar = {
    Unit = {
      ConditionEnvironment = lib.mkForce "";
      After = lib.mkForce "";
    };
    Service = {
      ExecStart = lib.mkForce "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
      RestartSec = "2s";
    };
    Install = {
      # Change this from graphical-session.target to default.target
      WantedBy = lib.mkForce [ "default.target" ]; 
    };
  };

  xdg.configFile."waybar/config".source = ../configs/waybar-config.jsonc;
  xdg.configFile."waybar/style.css".source = ../configs/waybar-style.css;
}
