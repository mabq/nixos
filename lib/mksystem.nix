{
  inputs,
  overlays,
}: {
  machine,
  user,
  profile,
}: let
  repoPath = "/home/${user}/.local/share/nixos-config"; # 1
  userProfilePath = "${repoPath}/users/${user}/${profile}";
  specialArgs = {inherit machine user profile repoPath userProfilePath;};
  machineConfig = ../machines/${machine}/configuration.nix;
  userNixOSConfig = ../users/${user}/${profile}/nixos.nix;
  userHMConfig = ../users/${user}/${profile}/home-manager.nix; # 2
in
  inputs.nixpkgs.lib.nixosSystem {
    inherit specialArgs; # 3
    modules = [
      # { nixpkgs.overlays = overlays; }
      inputs.disko.nixosModules.disko
      machineConfig
      userNixOSConfig
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true; # 4
        home-manager.useUserPackages = true; # 5
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.users.${user} = userHMConfig;
      }
    ];
  }
#
# 1. Must be constructed here. It cannot include `$HOME` or `~` since symlinks do not support these.
#    If you ever decide to change the repository directory or name, update this.
#
# 2. https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager#home-manager-vs-nixos
#
# 3. Must use `specialArgs`, `_module.args` causes infinite recursion when any of the passed arguments are used in the `imports` section of other modules.
#    https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-flake-and-module-system#pass-non-default-parameters-to-submodules
#
# 4. https://nix-community.github.io/home-manager/nixos-options.xhtml#nixos-opt-home-manager.useGlobalPkgs
#
# 5. https://nix-community.github.io/home-manager/nixos-options.xhtml#nixos-opt-home-manager.useUserPackages

