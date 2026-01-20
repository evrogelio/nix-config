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
    openfortivpn
    grim
    slurp
    swappy
    wl-clipboard
    dbeaver-bin
    lazygit
    delta
    lua-language-server
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.svelte-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages."@google/clasp"
    tailwindcss-language-server
    emmet-ls
    nautilus
    spotify
    prismlauncher
    scrcpy
    ruby-lsp
    unityhub
    ffmpeg
    discord
    obs-studio
    blender
    insomnia
    postman
    unstable.github-copilot-cli
  ];

  imports = [
    ./modules/hyprland.nix
    ./modules/wlogout.nix
    ./modules/zsh.nix
    ./modules/nvim.nix
    ./modules/ghostty.nix
    ./modules/kanata.nix
    ./modules/lock.nix
    ./modules/tmux.nix
    ./modules/udiskie.nix
  ];
  programs.home-manager.enable = true;
  programs.vscode.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}

