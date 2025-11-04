{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  users.groups.uinput = {};
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Monterrey";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Disable power button default behaviour
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rogelioev = {
    isNormalUser = true;
    description = "Rogelio Echavarria";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "uinput" "input" "podman" "adbusers"];
    packages = with pkgs; [];
    linger = true;
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "rogelioev";

  # Display Manager settings
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "hyprland";
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "rogelioev";
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Set Hyprland
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    # Core
    hyprland waybar wofi dunst

    # Audio & Bluetooth
    pipewire wireplumber pavucontrol bluez blueman bluez-tools

    # Network
    networkmanager networkmanagerapplet

    # Utils
    grim slurp wl-clipboard greetd.tuigreet

    # Brightness
    brightnessctl

    # Apps
    google-chrome git

    # Home manager
    home-manager
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.ubuntu-mono
  ];

  programs.zsh.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  programs.adb.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # List services that you want to enable:
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.blueman.enable = true;
  services.libinput = {
    enable = true;
  };

  services.udisks2.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
