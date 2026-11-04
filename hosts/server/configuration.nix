{ config, pkgs, lib, ... }:

{
  imports = [
    ../nixos-common.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "server";

  services.displayManager.sddm.enable = lib.mkForce false;
  programs.hyprland.enable = lib.mkForce false;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 25565 ];
  networking.firewall.allowedUDPPorts = [ 25565 ];

  environment.systemPackages = with pkgs; [
    podman-compose
    git
    htop
    tmux
  ];
}
