{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { nixpkgs
    , nixos-hardware
    , pre-commit-hooks
    , home-manager
    , ...
    }:
    let
      system = "x86_64-linux";
      username = "curry";

      pkgs-settings = {
        inherit system;
        config.allowUnfree = true;
        config.rocmSupport = true;
      };

      pkgs = (import nixpkgs pkgs-settings);

      home-manager-conf = {
        useGlobalPkgs = false;
        useUserPackages = true;
        backupCommand = pkgs.writeShellScript "home-manager-backup" ''
          set -eu

          target="$1"
          ts="$(date +%Y%m%d-%H%M%S)"
          backup="''${target}.home-manager-backup-''${ts}"
          i=0

          while [ -e "$backup" ]; do
            i=$((i + 1))
            backup="''${target}.home-manager-backup-''${ts}-''${i}"
          done

          mv -- "$target" "$backup"
        '';
        users.${username} = import ./home;
        extraSpecialArgs = {
          inherit username system;
        };
      };

      # Helper function to create a nixos system configuration
      mkSystem = machineDir: extraHardwareModules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit username;
          commonConfig = ./common.nix;
        };
        modules = [
          "${machineDir}/configuration.nix"
          "${machineDir}/hardware-configuration.nix"
          ./common.nix
          home-manager.nixosModules.home-manager
          { home-manager = home-manager-conf; }
        ] ++ extraHardwareModules;
      };
    in
    rec {
      formatter.${system} = pkgs.nixpkgs-fmt;
      
      nixosConfigurations = {
        desktop = mkSystem ./machines/desktop [
          nixos-hardware.nixosModules.framework-desktop-amd-ai-max-300-series
        ];
        
        laptop = mkSystem ./machines/laptop [ ];
        
        # Legacy: keep 'nixos' for backwards compatibility (points to desktop)
        nixos = nixosConfigurations.desktop;
      };
      
      checks.${system}.pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          nixpkgs-fmt = {
            enable = true;
            name = pkgs.lib.mkForce "Nix files format";
          };
        };
      };
      
      devShells.${system}.default = pkgs.mkShell {
        inherit (checks.${system}.pre-commit-check) shellHook;
      };
    };

}
