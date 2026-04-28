{
  overlays,
  nixpkgs,
  home-manager,
  inputs,
}: {
  machine,
  user,
}: let
  specialArgs = {inherit machine user inputs;};
  machineConfig = ../machines/${machine}/configuration.nix;
  userNixOSConfig = ../users/${user}/nixos.nix;
  userHMConfig = ../users/${user}/home-manager.nix; # 1
in
  nixpkgs.lib.nixosSystem {
    inherit specialArgs; # 2
    modules = [
      # { nixpkgs.overlays = overlays; }
      inputs.disko.nixosModules.disko
      machineConfig
      userNixOSConfig
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.users.${user} = userHMConfig;
      }
    ];
  }
# 1. https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager#home-manager-vs-nixos
# 2. Must use `specialArgs`, `_module.args` causes infinite recursion when any
# of the passed arguments are used in the `imports` section of other modules.
# See https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-flake-and-module-system#pass-non-default-parameters-to-submodules

