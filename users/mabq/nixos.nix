{
  config,
  lib,
  pkgs,
  user,
  ...
}:
with lib; {
  programs.zsh.enable = mkDefault true;

  environment.etc."zshenv.local".text = ''
    # This file is sourced by `/etc/zshenv` (read for all shells).
    # This option disables reading `/etc/zshrc` (read for interactive shells) and `/etc/zprofile (read for login shells)`.
    setopt NO_GLOBAL_RCS
  '';

  users.users.${user} = {
    isNormalUser = true;
    home = "/home/${user}";
    shell = pkgs.zsh;

    # Members of the `wheel` group can execute `sudo` without password.
    extraGroups =
      ["wheel"]
      ++ optionals config.virtualisation.docker.enable ["docker"];

    # Use `mkpasswd -m sha-512` to create a passwork hash.
    hashedPassword = "$6$slFKhHBtWmrAa8NN$dZD4TelNDAISrLJHAM.35K31m/0MszqHJ.7kuLdNC444FwprmHxvgU3SAcIgIeDpCFhO2EfWbU43JPnSrLGA01";

    # No need to check whether the service is enabled, if it is not the file exist without being used.
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjOlPls0gNkjBTOvXIbmm7HbSUOHM+erfwE4tdNVMLn"];
  };
}
