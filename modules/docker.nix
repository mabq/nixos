{
  lib,
  user,
  ...
}:
with lib; {
  virtualisation.docker.enable = mkDefault true;
  users.users.${user}.extraGroups = ["docker"];
}
