{...}: {
  imports = [
    ../_shared/configuration.nix
    ../_shared/disko/bios-ext4.nix
  ];

  system.stateVersion = "25.11"; # only update when reinstalling with a newer ISO
}
