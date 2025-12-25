{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ../../modules  # Import all system modules
  ];

  # Hostname
  networking.hostName = "topaz";

  # NixOS release version
  system.stateVersion = "24.11";
}
