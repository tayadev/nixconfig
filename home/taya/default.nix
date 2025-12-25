{ config, pkgs, inputs, ... }:

{
  imports = [
    ./home.nix
    ../modules  # Import shared home modules
  ];

  # Basic home-manager settings
  home.username = "taya";
  home.homeDirectory = "/home/taya";
  home.stateVersion = "24.11";  # Match NixOS version

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
