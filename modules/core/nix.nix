{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.core.nix;
in
{
  options.modules.core.nix = {
    enable = mkEnableOption "Nix configuration" // { default = true; };
  };

  config = mkIf cfg.enable {
    # Enable flakes and nix-command
    nix = {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;

        # Trusted users for multi-user mode
        trusted-users = [ "root" "@wheel" ];

        # Substituters and public keys for binary cache
        substituters = [
          "https://cache.nixos.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      };

      # Automatic garbage collection
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
  };
}
