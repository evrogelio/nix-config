{ config, pkgs, ... }:

{
  imports = [
    ../nixos-common.nix
    ./hardware-configuration.nix 
  ];

  networking.hostName = "server";

  services.displayManager.sddm.enable = false;
  programs.hyprland.enable = false;

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
