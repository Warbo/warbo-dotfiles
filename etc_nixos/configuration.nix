# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #fileSystems."/home".device = "/dev/sda6";

  # Use the GRUB 2 boot loader.
  boot = {
    loader.grub.enable = true;
    loader.grub.version = 2;
    # Define on which hard drive you want to install Grub.
    loader.grub.device = "/dev/sda";
    #kernelPackages = pkgs.linuxPackages_3_12;
    kernelModules = [ "kvm-intel" "tun" "virtio" ];
    kernel.sysctl."net.ipv4.tcp_sack" = 0;
  };
  networking = {
    hostName = "nixos";
    interfaceMonitor.enable = false; # Watch for plugged cable.
    firewall.enable = false;

    # NetworkManager
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  powerManagement.enable = true;

  time = {
    timeZone = "Europe/London";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    trayer networkmanagerapplet
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "gb";
    xkbOptions = "ctrl:nocaps";
    #desktopManager.xfce.enable = true;
    windowManager.xmonad.enable = true;
    windowManager.default = "xmonad";
    windowManager.xmonad.enableContribAndExtras = true;
    desktopManager.default = "none";
    displayManager = {
      auto = {
        enable = true;
        user = "chris"; # login as "chris"
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.chris = {
    name = "chris";
    group = "users";
    extraGroups = [ "wheel" "voice" "networkmanager" ];
    uid = 1000;
    createHome = true;
    home = "/home/chris";
    shell = "/run/current-system/sw/bin/bash";
  };
}
