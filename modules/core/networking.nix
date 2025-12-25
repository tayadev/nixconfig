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
    # Enable NetworkManager for easy network configuration (includes WiFi support)
    networking.networkmanager.enable = true;

    # Declarative WiFi network configuration
    networking.networkmanager.ensureProfiles = {
      environmentFiles = [ ];
      profiles = {
        RedHotNet5 = {
          connection = {
            id = "RedHotNet5";
            type = "wifi";
            autoconnect = "true";
          };
          wifi = {
            ssid = "RedHotNet5";
            mode = "infrastructure";
          };
          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = "4579d56f49a2338bf09f4acae335907191736083ad98a817231cac5e339002c8";
          };
          ipv4 = {
            method = "auto";
          };
          ipv6 = {
            method = "auto";
          };
        };
      };
    };

    # Enable wireless support and firmware
    hardware.enableRedistributableFirmware = true;
    networking.wireless.enable = false;  # Disable wpa_supplicant (conflicts with NetworkManager)

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

    # Make hosts file editable
    environment.etc.hosts.mode = "0644";
  };
}
