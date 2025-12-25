{ config, pkgs, ... }:

{
  # Enable home module features
  home.modules = {
    shell.bash.enable = true;
    desktop.plasma.enable = true;
    development.git.enable = true;
  };

  # User packages
  home.packages = with pkgs; [
    # Web browsers
    firefox
    chromium

    # Communication
    discord
    telegram-desktop

    # Utilities
    keepassxc
    vlc
    mpv
    spotify

    # Archives
    p7zip
    unrar

    # Development (user-level)
    vscode

    # Screenshot and screen recording
    flameshot
  ];

  # Environment variables
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # XDG user directories
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
