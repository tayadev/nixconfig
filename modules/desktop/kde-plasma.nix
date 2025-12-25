{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.desktop.kde-plasma;
in
{
  options.modules.desktop.kde-plasma = {
    enable = mkEnableOption "KDE Plasma 6 desktop environment";
  };

  config = mkIf cfg.enable {
    # Enable X11 and Wayland
    services.xserver.enable = true;

    # SDDM display manager
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # KDE Plasma 6
    services.desktopManager.plasma6.enable = true;

    # Enable sound with pipewire
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable dconf (required for GTK apps)
    programs.dconf.enable = true;

    # KDE Connect
    programs.kdeconnect.enable = true;

    # Partition Manager
    programs.partition-manager.enable = true;

    # Essential KDE packages
    environment.systemPackages = with pkgs; [
      # KDE Applications
      kdePackages.kcolorchooser
      kdePackages.kdialog
      kdePackages.dolphin
      kdePackages.spectacle  # Screenshot utility
      kdePackages.okular     # Document viewer
      kdePackages.gwenview   # Image viewer
      kdePackages.ark        # Archive manager
      kdePackages.filelight  # Disk usage analyzer

      # Terminal
      ghostty

      # Password manager
      bitwarden-desktop

      # Themes and customization
      libsForQt5.qtstyleplugin-kvantum
      papirus-icon-theme
    ];

    # Enable flatpak (optional, for additional KDE apps)
    services.flatpak.enable = true;
    xdg.portal.enable = true;

    # Enable Bluetooth support
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;
  };
}
