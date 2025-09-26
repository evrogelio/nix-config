{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
  };

  xdg.configFile."tmux/tmux.conf".source = ../configs/tmux/tmux.conf;
}

