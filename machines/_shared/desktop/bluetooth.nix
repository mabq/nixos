{
  lib,
  pkgs,
  ...
}:
with lib; {
  environment.systemPackages = with pkgs; [
    bluetui # TUI for managing bluetooth on Linux [2]
  ];

  hardware.bluetooth.enable = mkDefault true;
}
# In order for bluetui to work the pipewire user service must be active, try executing `wiremix` to start it.

