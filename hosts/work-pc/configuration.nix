{ config, pkgs, ... }:

{
  imports = [
    ../nixos-common.nix
    # ./hardware-configuration.nix
  ];
  
  networking.hostName = "work-pc";
}
