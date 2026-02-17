{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      # This ensures it targets the session correctly
      target = "graphical-session.target"; 
    };
  };

  # Customizing the service behavior
  systemd.user.services.waybar = {
    Unit = {
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      # Use the direct paths to your config in the Nix store/Home directory
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
      RestartSec = "2s";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  # Keep your existing file links
  xdg.configFile."waybar/config".source = ../configs/waybar-config.jsonc;
  xdg.configFile."waybar/style.css".source = ../configs/waybar-style.css;
}
