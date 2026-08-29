{ pkgs, inputs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  }; 
in
{
  imports = [
    ./zsh.nix
    ./nvim.nix
    ./ghostty.nix
    ./tmux.nix
    ./lsp.nix
  ];

  home.packages = with pkgs; [
    bun
    nodejs_24
    unzip
    gcc
    ripgrep
    lazygit
    delta
    nodePackages.typescript
    nodePackages."@google/clasp"
    ffmpeg
    vlc
    unrar
    zip
    unstable.github-copilot-cli
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
