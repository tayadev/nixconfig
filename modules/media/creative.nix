{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.media;
in
{
  config = mkIf cfg.enable {
    # Creative and media production tools
    environment.systemPackages = with pkgs; [
      # Image editing
      gimp
      inkscape
      krita
      imagemagick

      # 3D modeling and animation
      blender

      # Video editing
      obs-studio

      # Video players
      vlc
      mpv

      # Screen recording
      simplescreenrecorder

      # Media converters
      ffmpeg-full
      handbrake
    ];
  };
}
