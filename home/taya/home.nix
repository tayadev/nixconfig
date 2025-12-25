{ config, pkgs, ... }:

{
  # Enable home module features
  home.modules = {
    shell.bash.enable = true;
    desktop.plasma.enable = true;
    development.git.enable = true;
    development.vscode.enable = true;
  };

  # User packages
  home.packages = with pkgs; [
    # Web browsers
    vivaldi

    # Communication
    discord

    # Productivity
    anytype

    # Utilities
    mpv

    # Archives
    p7zip
    unrar

    # Screenshot and screen recording
    flameshot

    claude-code
  ];

  # Environment variables
  home.sessionVariables = {
    EDITOR = "vim";

    # Fix Chromium/Electron stuttering on Wayland + NVIDIA
    NIXOS_OZONE_WL = "1";  # Force native Wayland mode for Chromium/Electron apps
  };

  # XDG user directories
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
