{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.media;
in
{
  config = mkIf cfg.enable {
    # Audio production and tools
    environment.systemPackages = with pkgs; [
      # Audio editors
      audacity

      # Audio utilities
      pavucontrol  # PulseAudio/Pipewire volume control
      easyeffects  # Audio effects for Pipewire
    ];

    # Pipewire is already enabled in desktop/kde-plasma.nix
    # This just adds audio production specific configs

    # Real-time audio (for music production)
    security.rtkit.enable = true;
  };
}
