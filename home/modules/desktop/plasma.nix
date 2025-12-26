{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.home.modules.desktop.plasma;
in
{
  options.home.modules.desktop.plasma = {
    enable = mkEnableOption "KDE Plasma user configuration";
  };

  config = mkIf cfg.enable {
    # Use plasma-manager for declarative KDE config
    programs.plasma = {
      enable = true;

      # Workspace settings
      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        cursor = {
          theme = "breeze_cursors";
          size = 24;
        };
        iconTheme = "Papirus-Dark";
        wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Kay/contents/images/1920x1080.png";
      };

      # Set default terminal emulator
      configFile."kdeglobals"."General"."TerminalApplication" = "ghostty";

      # Window behavior - enable hover to focus
      configFile."kwinrc"."Windows"."FocusPolicy" = "FocusFollowsMouse";

      # Hotkeys
      hotkeys.commands."launch-terminal" = {
        name = "Launch Terminal";
        key = "Meta+Return";
        command = "ghostty";
      };

      # Configure panels (optional - uncomment to customize)
      # panels = [
      #   {
      #     location = "bottom";
      #     widgets = [
      #       "org.kde.plasma.kickoff"
      #       "org.kde.plasma.pager"
      #       "org.kde.plasma.taskmanager"
      #       "org.kde.plasma.systemtray"
      #       "org.kde.plasma.digitalclock"
      #     ];
      #   }
      # ];
    };
  };
}
