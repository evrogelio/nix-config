{ config, pkgs, ... }:

{
  home.packages = [ pkgs.kanata ];

  # Put your kanata.kbd into ~/.config/kanata/
  xdg.configFile."kanata/kanata.kbd".source = ../configs/kanata.kbd;

  systemd.user.services.kanata = {
    Unit = {
      Description = "Kanata keyboard remapper";
      After = [ "graphical.target" ];
    };
    Service = {
      ExecStart = "${pkgs.kanata}/bin/kanata -c %h/.config/kanata/kanata.kbd";
      Restart = "always";
    };
    Install.WantedBy = [ "default.target" ];
  };
}

