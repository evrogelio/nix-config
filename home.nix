{ config, pkgs, inputs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  }; 
in
{
  home.username = "rogelioev";
  home.homeDirectory = "/home/rogelioev";
  home.stateVersion = "25.05";
  
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    imagemagick
    bun
    nodejs_24
    obsidian
    unzip
    gcc
    ripgrep
    podman-compose
    buildah
    skopeo
    grim
    slurp
    swappy
    wl-clipboard
    dbeaver-bin
    lazygit
    delta
    nodePackages.typescript
    nodePackages."@google/clasp"
    nautilus
    prismlauncher
    scrcpy
    ffmpeg
    discord
    obs-studio
    blender
    insomnia
    postman
    unstable.github-copilot-cli
    vlc
    calibre
    unrar
    zip
    kcc
    brave
    figma-linux
    transmission_4-qt
    playerctl
  ];

  imports = [
    ./modules/hyprland.nix
    ./modules/hyprpaper.nix
    ./modules/wlogout.nix
    ./modules/zsh.nix
    ./modules/nvim.nix
    ./modules/ghostty.nix
    ./modules/kanata.nix
    ./modules/lock.nix
    ./modules/tmux.nix
    ./modules/udiskie.nix
    ./modules/waybar.nix
    ./modules/wofi.nix
    ./modules/cider.nix
    ./modules/lsp.nix
  ];
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}

