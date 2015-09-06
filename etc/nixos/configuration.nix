# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.gummiboot.timeout = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.cleanTmpDir = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    jre = pkgs.oraclejre8;
    jdk = pkgs.oraclejdk8;
  };
  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/LosAngeles";

  # List packages installed in system profile. To search by name, run:
  environment.systemPackages = with pkgs; [
    wget vim zsh git nix-prefetch-scripts firefox openvpn vpnc
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system and KDE Desktop Environment.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "mac";
    xkbOptions = "eurosign:e";
    displayManager.kdm = {
      enable = true;
    };
    desktopManager.kde5.enable = true; #If you want you can use kde4 also
    videoDrivers = [ "intel" "nouveau" ];
  
    # Configure touchpad
    synaptics = {
      enable = true;
      dev = "/dev/input/event*";
      twoFingerScroll = true;
      accelFactor = "0.0001";
      buttonsMap = [ 1 3 2 ];
    };
    multitouch.enable = true;
    multitouch.invertScroll = true;
  };
  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = true;
  users.extraUsers.rrohitasva = {
    isNormalUser = true;
    uid = 1000;
    group  = "users";
    description = "Home Account";
    extraGroups = [ "wheel" ];
    home = "/home/rrohitasva";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}
