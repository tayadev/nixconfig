{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.core.locale;
in
{
  options.modules.core.locale = {
    enable = mkEnableOption "Locale configuration" // { default = true; };
  };

  config = mkIf cfg.enable {
    # Set your time zone
    time.timeZone = "Europe/Zurich";  # Change this to your timezone

    # Internationalization settings
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_CH.UTF-8";
      LC_IDENTIFICATION = "de_CH.UTF-8";
      LC_MEASUREMENT = "de_CH.UTF-8";
      LC_MONETARY = "de_CH.UTF-8";
      LC_NAME = "de_CH.UTF-8";
      LC_NUMERIC = "de_CH.UTF-8";
      LC_PAPER = "de_CH.UTF-8";
      LC_TELEPHONE = "de_CH.UTF-8";
      LC_TIME = "de_CH.UTF-8";
    };

    # Console configuration
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";  # Change this to your keyboard layout
    };

    # Fonts
    fonts = {
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        font-awesome
      ];

      fontconfig = {
        defaultFonts = {
          serif = [ "Noto Serif" ];
          sansSerif = [ "Noto Sans" ];
          monospace = [ "FiraCode Nerd Font Mono" ];
        };
      };
    };
  };
}
