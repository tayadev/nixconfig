{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.home.modules.development.git;
in
{
  options.home.modules.development.git = {
    enable = mkEnableOption "Git configuration";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;

      # IMPORTANT: Update these with your information!
      settings = {
        user.name = "Taya Crystals";
        user.email = "taya@taya.net";

        init.defaultBranch = "main";
        pull.rebase = false;
        core.editor = "vim";

        # Better diff output
        diff.algorithm = "histogram";

        # Useful aliases
        alias = {
          co = "checkout";
          br = "branch";
          ci = "commit";
          st = "status";
          unstage = "reset HEAD --";
          last = "log -1 HEAD";
          lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        };
      };
    };

    # Git diff highlighting
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "Dracula";
      };
    };
  };
}
