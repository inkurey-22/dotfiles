# Multi-Machine NixOS Configuration

This dotfiles repository now supports multiple machines (desktop and laptop) with separate configurations.

## Directory Structure

```
.
├── flake.nix                          # Defines configurations for desktop & laptop
├── common.nix                         # Shared settings across all machines
├── machines/
│   ├── desktop/
│   │   ├── configuration.nix          # Desktop-specific settings
│   │   └── hardware-configuration.nix # Desktop hardware scan
│   └── laptop/
│       ├── configuration.nix          # Laptop-specific settings
│       └── hardware-configuration.nix # Laptop hardware scan
├── home/                              # Shared home-manager config (applies to all machines)
└── ...
```

## Usage

### Rebuild Desktop Configuration

```bash
cd /path/to/dotfiles
sudo nixos-rebuild switch --flake .#desktop
```

### Rebuild Laptop Configuration

```bash
cd /path/to/dotfiles
sudo nixos-rebuild switch --flake .#laptop
```

### Legacy Command (for backwards compatibility)

```bash
sudo nixos-rebuild switch --flake .#nixos
# This will build the desktop configuration
```

## Setting Up Your Laptop

1. Generate your laptop's hardware configuration:
   ```bash
   sudo nixos-generate-config
   ```

2. Copy the generated files:
   ```bash
   sudo cp /etc/nixos/hardware-configuration.nix ~/.dotfiles/machines/laptop/
   ```

3. Update the UUIDs in `machines/laptop/configuration.nix`:
   - Look for `LAPTOP-UUID` markers and replace with actual values from the hardware config
   - You can also check `/etc/crypttab` or `blkid` command for LUKS UUIDs

4. Customize other laptop-specific settings as needed (power management, touchpad, etc.)

## File Explanations

### `common.nix`
Contains all shared configuration across machines:
- Bootloader settings
- Desktop environment (Plasma)
- Locale, timezone, fonts
- Pipewire, Docker, Flatpak
- Base packages and users

**Do not** put machine-specific settings here (hostName, LUKS devices, hardware modules).

### `machines/*/configuration.nix`
Machine-specific overrides and settings:
- `networking.hostName` - unique per machine
- LUKS device configurations
- Machine-specific packages or services
- Hardware-specific optimizations

### `machines/*/hardware-configuration.nix`
Generated hardware scan results:
- Kernel modules
- File systems and LUKS mappings
- CPU-specific settings
- Do not edit manually - regenerate with `nixos-generate-config` if hardware changes

## Adding Machine-Specific Settings

### For Desktop Only

Edit `machines/desktop/configuration.nix`:

```nix
{
  imports = [ ../../common.nix ];

  networking.hostName = "desktop";

  # Your desktop-specific settings
  services.myService.enable = true;
}
```

### For Laptop Only

Edit `machines/laptop/configuration.nix`:

```nix
{
  imports = [ ../../common.nix ];

  networking.hostName = "laptop";

  # Your laptop-specific settings
  services.powerManagement.enable = true;
  services.fwupd.enable = true;  # Framework-specific
}
```

### For All Machines

Edit `common.nix` to add the setting before other imports.

## Tips

1. **Test before switching**: Use `nixos-rebuild build --flake .#desktop` to build without switching
2. **Keep UUIDs in sync**: If you change storage, regenerate hardware configs and update LUKS UUIDs
3. **Shared home-manager**: The `home/` directory is still shared - create per-user subdirs if you have multiple users
4. **Git workflow**: Create branches per machine for major changes if preferred

## Troubleshooting

If `nixos-rebuild` complains about missing attributes:
- Ensure you're using the correct flake output: `.#desktop` or `.#laptop`
- Check that hardware UUIDs in configuration match your actual system (use `blkid`)
- Verify LUKS devices are correctly mapped to the right partitions

## Next Steps

1. Update `machines/laptop/hardware-configuration.nix` with your laptop's actual hardware
2. Update laptop-specific LUKS UUIDs in `machines/laptop/configuration.nix`
3. Test the desktop config first: `sudo nixos-rebuild switch --flake .#desktop`
4. Once working, test the laptop config on your laptop
