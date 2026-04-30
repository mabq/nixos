{
  lib,
  user,
  ...
}:
with lib; {
  virtualisation.docker.enable = mkDefault false;
  users.users.${user}.extraGroups = ["docker"];
}
