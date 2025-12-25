{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.media;
in
{
  imports = [
    ./audio.nix
    ./creative.nix
  ];

  options.modules.media = {
    enable = mkEnableOption "Media and creative tools";
  };
}
