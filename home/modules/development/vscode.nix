{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.home.modules.development.vscode;
in
{
  options.home.modules.development.vscode = {
    enable = mkEnableOption "VSCode configuration";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;

      # Use mutableExtensionsDir to allow installing themes from marketplace
      mutableExtensionsDir = true;

      profiles.default = {
        extensions =
        with pkgs.vscode-extensions;
        [
          # Vim extension
          vscodevim.vim

          # Icon theme
          pkief.material-icon-theme

          # Additional useful extensions
          jnoortheen.nix-ide
          ms-python.python
          rust-lang.rust-analyzer
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          # Horizon theme (not in nixpkgs, install from marketplace)
          {
            name = "horizon-theme-vscode";
            publisher = "alexandernanberg";
            version = "1.0.1";
            hash = "sha256-jdtc/v4aX5wAjcs0bIpL808l4EA3o362u0sgzas27YU=";
          }
        ];

        userSettings = {
        # Theme settings
        "workbench.colorTheme" = "Horizon";

        # Editor settings
        "editor.fontSize" = 14;
        "editor.fontFamily" = "'JetBrains Mono', 'Fira Code', monospace";
        "editor.fontLigatures" = true;
        "editor.tabSize" = 2;
        "editor.insertSpaces" = true;
        "editor.detectIndentation" = true;
        "editor.renderWhitespace" = "boundary";
        "editor.rulers" = [
          80
          120
        ];
        "editor.minimap.enabled" = true;
        "editor.lineNumbers" = "on";
        "editor.cursorBlinking" = "smooth";
        "editor.smoothScrolling" = true;

        # Vim settings
        "vim.useSystemClipboard" = true;
        "vim.hlsearch" = true;
        "vim.leader" = "<space>";

        # Files settings
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;

        # Workbench settings
        "workbench.startupEditor" = "none";
        "workbench.iconTheme" = "material-icon-theme";

        # Terminal settings
        "terminal.integrated.fontSize" = 13;
        "terminal.integrated.fontFamily" = "monospace";

        # Nix settings
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";

        # Format on save
        "editor.formatOnSave" = true;
        "[nix]" = {
          "editor.tabSize" = 2;
        };

        # Extension: vscodevim.vim settings
        "extensions.autoUpdate" = false; # Prevent auto-updating declarative extensions
        };

        keybindings = [
        {
          key = "ctrl+h";
          command = "workbench.action.navigateLeft";
        }
        {
          key = "ctrl+l";
          command = "workbench.action.navigateRight";
        }
        {
          key = "ctrl+k";
          command = "workbench.action.navigateUp";
        }
        {
          key = "ctrl+j";
          command = "workbench.action.navigateDown";
        }
        ];
      };
    };
  };
}
