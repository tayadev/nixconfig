{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Enable module features
  modules = {
    # Core modules (enabled by default)
    core = {
      nix.enable = true;
      boot.enable = true;
      networking.enable = true;
      locale.enable = true;
    };

    # Desktop environment
    desktop.kde-plasma.enable = true;

    # Development tools
    development.enable = true;

    # Gaming support
    gaming.enable = true;

    # Hardware support
    hardware.fido2.enable = true;

    # Media and creative tools
    media.enable = true;
  };

  # Enable passwordless sudo for wheel group
  security.sudo.wheelNeedsPassword = false;

  # User accounts
  users.users.taya = {
    isNormalUser = true;
    description = "Taya";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "plugdev"
    ];
    hashedPassword = "$6$5t11bOwky4G5kR1e$an8G.JYT5fO5/HOdFribIPmqCFmQrkw2SNF5IWttIXr67eCF2iC22S6gubFE5TpTG9WQUwo/vjtAS1q9ipujQ1";
  };

  # Hardware configuration
  # Enable NVIDIA drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; # Use proprietary driver
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Blacklist nouveau/nova to force proprietary NVIDIA driver
  boot.blacklistedKernelModules = [ "nouveau" "nova" "nova_core" ];

  # Intel microcode updates (already configured in hardware-configuration.nix)
  hardware.cpu.intel.updateMicrocode = true;

  # System-wide packages
  environment.systemPackages = with pkgs; [
    # Basic utilities
    vim
    wget
    curl
    git
    htop
    unzip
    zip
    tree
    file
    jq
  ];
}
