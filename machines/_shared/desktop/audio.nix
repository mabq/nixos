{
  lib,
  pkgs,
  ...
}:
with lib; {
  environment.systemPackages = with pkgs; [
    wiremix # Simple TUI mixer for PipeWire
  ];

  services.pipewire = {
    enable = mkDefault true;
    alsa.enable = mkDefault true;
    jack.enable = mkDefault true;
    pulse.enable = mkDefault true;
  };

  security.rtkit.enable = mkDefault true; # Required by pipewire
}
