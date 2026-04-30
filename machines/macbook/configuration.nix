{lib, ...}: {
  imports = [
    ../_shared/configuration.nix
    ../_shared/disko/uefi-ext4-encrypted.nix
    ../_shared/network/networkd.nix
  ];

  # Sometimes facter tries to use GRUB on UEFI systems, make sure it uses systemd-boot.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.11"; # only update when reinstalling with a newer ISO
}
