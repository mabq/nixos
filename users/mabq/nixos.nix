{
  config,
  lib,
  pkgs,
  user,
  ...
}:
with lib; {
  # environment.localBinInPath = true; # add `~/.local/bin` to PATH

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
