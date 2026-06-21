{ config, pkgs, ... }:

{
  # Desktop-specific hostname
  networking.hostName = "desktop";

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "curry" ];

  # Desktop-specific LUKS configuration (for swap)
  boot.initrd.luks.devices."luks-5ce730a9-d295-4e17-9a0a-b442bc5e6c32".device = "/dev/disk/by-uuid/5ce730a9-d295-4e17-9a0a-b442bc5e6c32";
}
