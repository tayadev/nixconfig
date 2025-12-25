{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.home.modules.shell.zsh;
in
{
  options.home.modules.shell.zsh = {
    enable = mkEnableOption "Zsh shell configuration";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;  # Fish-like autosuggestions
      syntaxHighlighting.enable = true;  # Syntax highlighting as you type

      shellAliases = {
        # Common aliases
        ll = "ls -alh";
        la = "ls -A";
        l = "ls -CF";
        ".." = "cd ..";
        "..." = "cd ../..";

        # NixOS specific (uses current hostname dynamically)
        rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos#$(hostname)";
        update = "nix flake update ~/.config/nixos && sudo nixos-rebuild switch --flake ~/.config/nixos#$(hostname)";
        clean = "sudo nix-collect-garbage --delete-older-than 14d";

        # Git shortcuts
        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git log --oneline --graph";
      };

      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
        ignoreDups = true;
        ignoreSpace = true;
        share = true;  # Share history between sessions
      };

      initContent = ''
        # Enhanced completion settings
        zstyle ':completion:*' menu select  # Interactive menu for completions
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case-insensitive completion
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"  # Colored completion
        zstyle ':completion:*' rehash true  # Auto-rehash commands
        zstyle ':completion:*' accept-exact '*(N)'
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path ~/.zsh/cache

        # Better completion for kill command
        zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
        zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

        # Better completion for cd
        zstyle ':completion:*:cd:*' ignore-parents parent pwd

        # Disable beeping
        unsetopt BEEP

        # Enable Vi mode (optional, comment out if you prefer Emacs mode)
        # bindkey -v
      '';
    };

    # zoxide - smarter cd command
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    # direnv - automatic environment switching
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # fzf - fuzzy finder
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    # eza - modern ls replacement with better colors
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
    };
  };
}
