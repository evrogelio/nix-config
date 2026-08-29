{ pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./wlogout.nix
    ./kanata.nix
    ./lock.nix
    ./udiskie.nix
    ./waybar.nix
    ./wofi.nix
    ./cider.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    dunst
    pavucontrol
    google-chrome
    imagemagick
    obsidian
    podman-compose
    buildah
    skopeo
    grim
    slurp
    swappy
    wl-clipboard
    dbeaver-bin
    nautilus
    prismlauncher
    scrcpy
    discord
    obs-studio
    blender
    insomnia
    postman
    calibre
    kcc
    brave
    figma-linux
    transmission_4-qt
    playerctl
  ];
}
