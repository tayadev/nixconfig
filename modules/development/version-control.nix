{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.development;
in
{
  config = mkIf cfg.enable {
    # Version control tools
    environment.systemPackages = with pkgs; [
      git
      git-lfs
      gh  # GitHub CLI
      lazygit
    ];

    # Enable git system-wide
    programs.git = {
      enable = true;
      lfs.enable = true;
    };
  };
}
