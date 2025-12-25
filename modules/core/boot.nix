{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.core.boot;
in
{
  options.modules.core.boot = {
    enable = mkEnableOption "Boot configuration" // { default = true; };
  };

  config = mkIf cfg.enable {
    # Use systemd-boot as the bootloader
    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;  # Keep last 10 generations
      };
      efi.canTouchEfiVariables = true;
    };

    # Latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
