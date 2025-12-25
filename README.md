# Taya's NixOS config

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