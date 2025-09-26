{ pkgs, ... }:

{
  programs.neovim.enable = true;
  xdg.configFile."nvim".source = ../configs/nvim;
  xdg.configFile."nvim/lazy-lock.json".enable = false;
}
