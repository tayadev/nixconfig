{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.development;
in
{
  imports = [
    ./languages.nix
    ./editors.nix
    ./version-control.nix
  ];

  options.modules.development = {
    enable = mkEnableOption "Development tools and environments";
  };

  config = mkIf cfg.enable {
    # Docker/Podman for containerization
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
    };

    # Add user to docker group (configured in host configuration)
    users.users.taya.extraGroups = [ "docker" ];
  };
}
