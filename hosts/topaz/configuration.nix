{ config, lib, pkgs, ... }:

{
  # Enable module features
  modules = {
    # Core modules (enabled by default)
    core = {
      nix.enable = true;
      boot.enable = true;
      networking.enable = true;
      locale.enable = true;
    };

    # Desktop environment
    desktop.kde-plasma.enable = true;

    # Development tools
    development.enable = true;

    # Gaming support
    gaming.enable = true;

    # Media and creative tools
    media.enable = true;
  };

  # User accounts
  users.users.taya = {
    isNormalUser = true;
    description = "Taya";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    initialPassword = "password";  # Change this after first login!
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    # Basic utilities
    vim
    wget
    curl
    git
    htop
    unzip
    zip
    tree
    file
  ];
}
