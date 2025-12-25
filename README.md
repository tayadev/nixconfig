# NixOS Configuration for topaz

A modular, flake-based NixOS configuration using flake-parts and home-manager.

## Features

- **Modular Structure**: Easy to enable/disable features
- **Flake-parts**: Clean organization of flake outputs
- **Home-manager**: Declarative user configuration
- **KDE Plasma 6**: Modern desktop environment with Wayland support
- **Development Tools**: Python, Node.js, Rust, Go, C/C++, Docker
- **Gaming**: Steam, Lutris, GameMode, controller support
- **Media/Creative**: GIMP, Blender, Kdenlive, OBS Studio

## Prerequisites

Before using this configuration, you need:

1. A working NixOS installation
2. Git installed
3. Flakes enabled (this config enables them automatically)

## Initial Setup

### 1. Generate Hardware Configuration

First, generate your hardware configuration:

```bash
sudo nixos-generate-config --show-hardware-config > hosts/topaz/hardware-configuration.nix
```

This will replace the placeholder file with your actual hardware configuration.

### 2. Update Git Configuration

Edit `home/modules/development/git.nix` and update:

```nix
userName = "Your Name";       # Change this
userEmail = "your.email@example.com";  # Change this
```

### 3. Update Timezone (Optional)

Edit `modules/core/locale.nix` and change the timezone if needed:

```nix
time.timeZone = "America/New_York";  # Change to your timezone
```

### 4. Initialize Git Repository

This configuration uses flakes, which require files to be tracked by git:

```bash
cd ~/Desktop/nixconfig  # or wherever you placed this config
git init
git add .
git commit -m "Initial NixOS configuration"
```

### 5. Deploy the Configuration

```bash
sudo nixos-rebuild switch --flake .#topaz
```

## Directory Structure

```
nixconfig/
├── flake.nix                 # Main flake entry point
├── flake.lock                # Lock file (auto-generated)
├── lib/                      # Helper functions
├── hosts/topaz/              # Host-specific configuration
├── modules/                  # System-level modules
│   ├── core/                 # Core system (boot, nix, networking, locale)
│   ├── desktop/              # Desktop environment (KDE Plasma)
│   ├── development/          # Development tools
│   ├── gaming/               # Gaming support
│   └── media/                # Media and creative tools
└── home/                     # User-level configuration
    ├── taya/                 # User-specific config
    └── modules/              # Reusable home modules
```

## Usage

### Rebuilding the System

After making changes to your configuration:

```bash
sudo nixos-rebuild switch --flake .#topaz
```

Or use the alias (after first rebuild):

```bash
rebuild  # Defined in bash.nix
```

### Updating Dependencies

Update all flake inputs:

```bash
nix flake update
```

Update and rebuild:

```bash
update  # Alias defined in bash.nix
```

### Cleaning Old Generations

Remove old system generations:

```bash
sudo nix-collect-garbage --delete-older-than 14d
```

Or use the alias:

```bash
clean  # Defined in bash.nix
```

### Testing in a VM

Before switching, you can test your configuration in a VM:

```bash
nixos-rebuild build-vm --flake .#topaz
./result/bin/run-topaz-vm
```

## Customization

### Enabling/Disabling Features

Edit `hosts/topaz/configuration.nix` and set module enables:

```nix
modules = {
  desktop.kde-plasma.enable = true;  # Set to false to disable
  development.enable = true;
  gaming.enable = false;  # Disable gaming features
  media.enable = true;
};
```

### Adding New Packages

**System-wide packages**: Edit `hosts/topaz/configuration.nix`:

```nix
environment.systemPackages = with pkgs; [
  your-package-here
];
```

**User packages**: Edit `home/taya/home.nix`:

```nix
home.packages = with pkgs; [
  your-package-here
];
```

### Customizing KDE Plasma

User-level KDE settings are in `home/modules/desktop/plasma.nix`.

You can customize:
- Theme and appearance
- Wallpaper
- Keyboard shortcuts
- Panel layout
- Widgets

See [plasma-manager documentation](https://github.com/nix-community/plasma-manager) for all options.

### Adding a New Module

1. Create the module file in the appropriate category:
   ```bash
   # For system modules
   touch modules/category/my-module.nix

   # For home modules
   touch home/modules/category/my-module.nix
   ```

2. Follow the module pattern:
   ```nix
   { config, lib, pkgs, ... }:

   with lib;

   let
     cfg = config.modules.category.my-module;
   in
   {
     options.modules.category.my-module = {
       enable = mkEnableOption "My module description";
     };

     config = mkIf cfg.enable {
       # Your configuration here
     };
   }
   ```

3. Import it in the category's `default.nix`:
   ```nix
   imports = [
     ./my-module.nix
   ];
   ```

4. Enable it in your host configuration

## Multiple Hosts

To add another machine:

1. Create a new directory: `hosts/new-hostname/`
2. Copy the structure from `hosts/topaz/`
3. Generate hardware config for the new host
4. Add the new configuration to `flake.nix`:
   ```nix
   nixosConfigurations = {
     topaz = ...;
     new-hostname = inputs.nixpkgs.lib.nixosSystem {
       # Same structure as topaz
     };
   };
   ```

## Troubleshooting

### Flake errors

If you get "git tree is dirty" errors:
```bash
git add .
```

### Build errors

Check syntax:
```bash
nix flake check
```

### Can't find packages

Search for packages:
```bash
nix search nixpkgs package-name
```

### Rollback to previous generation

If something breaks:
```bash
sudo nixos-rebuild switch --rollback
```

Or at boot, select a previous generation from the bootloader menu.

## Security Notes

1. **Change default password**: The initial password for user `taya` is set to "changeme". Change it immediately after first login:
   ```bash
   passwd
   ```

2. **SSH is disabled** by default. To enable it, edit `modules/core/networking.nix`:
   ```nix
   services.openssh.enable = true;
   ```

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Flake-parts Documentation](https://flake.parts/)
- [Plasma Manager](https://github.com/nix-community/plasma-manager)

## License

This configuration is provided as-is for personal use. Feel free to fork and modify as needed.
