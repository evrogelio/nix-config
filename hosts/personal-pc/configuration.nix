{ config, pkgs, ... }:

{
  imports = [
    ../nixos-common.nix
    ./hardware-configuration.nix
  ];
  
  networking.hostName = "personal-pc"; # Define your hostname.
}
