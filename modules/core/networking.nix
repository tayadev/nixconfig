{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.core.networking;
in
{
  options.modules.core.networking = {
    enable = mkEnableOption "Networking configuration" // { default = true; };
  };

  config = mkIf cfg.enable {
    # Enable NetworkManager for easy network configuration
    networking.networkmanager.enable = true;

    # Firewall configuration
    networking.firewall = {
      enable = true;
      # Allow specific ports if needed
      # allowedTCPPorts = [ ];
      # allowedUDPPorts = [ ];
    };

    # Enable SSH server (optional, can be disabled)
    services.openssh = {
      enable = false;  # Set to true if you need SSH access
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
}
