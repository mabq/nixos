{
  inputs,
  repoPath,
  overlays,
}: {
  machine,
  user,
  profile,
}: let
  specialArgs = {inherit inputs repoPath machine user profile;};
  machineConfig = ../machines/${machine}/configuration.nix;
  userNixOSConfig = ../users/${user}/${profile}/nixos.nix;
  userHMConfig = ../users/${user}/${profile}/home-manager.nix; # 1
in
  inputs.nixpkgs.lib.nixosSystem {
    inherit specialArgs; # 2
    modules = [
      # { nixpkgs.overlays = overlays; }
      inputs.disko.nixosModules.disko
      machineConfig
      userNixOSConfig
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true; # 3
        home-manager.useUserPackages = true; # 4
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.users.${user} = userHMConfig;
      }
    ];
  }
#
# 1. https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager#home-manager-vs-nixos
#
# 2. Must use `specialArgs`, `_module.args` causes infinite recursion when any of the passed arguments are used in the `imports` section of other modules.
#    https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-flake-and-module-system#pass-non-default-parameters-to-submodules
#
# 3. https://nix-community.github.io/home-manager/nixos-options.xhtml#nixos-opt-home-manager.useGlobalPkgs
#
# 4. https://nix-community.github.io/home-manager/nixos-options.xhtml#nixos-opt-home-manager.useUserPackages

