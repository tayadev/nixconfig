{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.gaming;
in
{
  imports = [
    ./steam.nix
  ];

  options.modules.gaming = {
    enable = mkEnableOption "Gaming support and optimizations";
  };
}
