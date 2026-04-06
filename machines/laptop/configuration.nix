{ config, pkgs, ... }:

{
  # Laptop-specific hostname
  networking.hostName = "laptop";

  # Laptop swap LUKS device
  boot.initrd.luks.devices."luks-b0be0b35-9f41-43d5-a5c3-dc50cdd058a4".device = "/dev/disk/by-uuid/b0be0b35-9f41-43d5-a5c3-dc50cdd058a4";
}
