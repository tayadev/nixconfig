{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.gaming;
in
{
  config = mkIf cfg.enable {
    # Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };

    # GameMode for performance optimization
    programs.gamemode.enable = true;

    # Graphics drivers
    hardware.graphics = {
      enable = true;
      enable32Bit = true;  # Required for 32-bit games
    };

    # Gaming-related packages
    environment.systemPackages = with pkgs; [
      # Game launchers
      lutris
      
      # Performance monitoring
      mangohud
      goverlay

      # Gaming utilities
      wine
      winetricks
      protonup-qt
    ];

    # Enable gamepad support
    hardware.xone.enable = true;  # Xbox controller support
  };
}
