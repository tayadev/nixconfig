{
  description = "NixOS Configuration for topaz";

  inputs = {
    # Core dependencies
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Flake-parts for modular flake structure
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Home-manager for user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Plasma-manager for declarative KDE configuration
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      # Supported systems
      systems = [ "x86_64-linux" ];

      # Per-system configuration
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        # Development shell
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixfmt-rfc-style
            nil  # Nix LSP
          ];
        };

        # Formatter for `nix fmt`
        formatter = pkgs.nixfmt-rfc-style;
      };

      # Flake-level configuration
      flake = {
        # Custom library functions
        lib = import ./lib { inherit (inputs.nixpkgs) lib; };

        # NixOS configurations
        nixosConfigurations = {
          topaz = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
              inherit (inputs) self;
            };
            modules = [
              # Host-specific configuration
              ./hosts/topaz

              # Home-manager NixOS module
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = { inherit inputs; };
                home-manager.users.taya = import ./home/taya;

                # Plasma-manager integration
                home-manager.sharedModules = [
                  inputs.plasma-manager.homeManagerModules.plasma-manager
                ];
              }
            ];
          };
        };
      };
    };
}
