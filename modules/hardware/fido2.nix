{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.hardware.fido2;
in
{
  options.modules.hardware.fido2 = {
    enable = mkEnableOption "FIDO2/U2F hardware support for passkeys";
  };

  config = mkIf cfg.enable {
    # Enable pcscd for smart card support (required for some FIDO2 devices)
    services.pcscd.enable = true;

    # Add udev rules for FIDO devices
    services.udev.packages = with pkgs; [
      # FIDO2/U2F udev rules
      libu2f-host
      yubikey-personalization
    ];

    # Additional udev rules for BLE passkey support
    services.udev.extraRules = ''
      # FIDO2/U2F devices
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", MODE="0660", GROUP="plugdev", TAG+="uaccess"

      # Allow access to FIDO devices over BLE
      ACTION=="add", SUBSYSTEM=="bluetooth", ENV{DEVTYPE}=="link", TAG+="uaccess"

      # Generic FIDO U2F
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev", ATTRS{idVendor}=="*", TAG+="uaccess", TAG+="udev-acl"
    '';

    # Create plugdev group for device access
    users.groups.plugdev = {};

    # Install useful utilities
    environment.systemPackages = with pkgs; [
      yubikey-manager
      libu2f-host
    ];
  };
}
