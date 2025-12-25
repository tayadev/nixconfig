{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.home.modules.shell.bash;
in
{
  options.home.modules.shell.bash = {
    enable = mkEnableOption "Bash shell configuration";
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
      enableCompletion = true;

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

      bashrcExtra = ''
        # Custom prompt
        PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

        # Enhanced bash completion settings
        bind 'set completion-ignore-case on'           # Case-insensitive completion
        bind 'set show-all-if-ambiguous on'            # Show completions immediately on first tab
        bind 'set colored-stats on'                    # Color completion suggestions by file type
        bind 'set visible-stats on'                    # Append file type indicators
        bind 'set mark-symlinked-directories on'       # Mark symlinked directories with /
        bind 'set colored-completion-prefix on'        # Color the common prefix in completions
        bind 'set menu-complete-display-prefix on'     # Show prefix before cycling through completions
      '';
    };

    # zoxide - smarter cd command
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    # direnv - automatic environment switching
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
