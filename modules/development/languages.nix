{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.development;
in
{
  config = mkIf cfg.enable {
    # Programming languages and runtimes
    environment.systemPackages = with pkgs; [
      # Python
      python3
      python312Packages.pip
      python312Packages.virtualenv

      # Node.js
      nodejs_22
      nodePackages.npm
      nodePackages.pnpm
      yarn

      # Rust
      rustc
      cargo
      rustfmt
      clippy

      # Go
      go
      gopls

      # C/C++
      gcc
      clang
      cmake
      gnumake

      # Build tools
      pkg-config
      automake
      autoconf
      libtool

      # Debugging
      gdb
      lldb
    ];

    # Enable direnv for per-project environments
    programs.direnv.enable = true;
  };
}
