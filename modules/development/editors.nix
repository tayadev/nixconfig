{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.development;
in
{
  config = mkIf cfg.enable {
    # Text editors and IDEs (system-level)
    environment.systemPackages = with pkgs; [
      # Editors
      neovim
      vim

      # Language servers (for editor integration)
      nil  # Nix LSP
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      rust-analyzer
      gopls
      clang-tools
      python312Packages.python-lsp-server
    ];
  };
}
