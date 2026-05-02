{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ananicy-cpp
    ananicy-rules-cachyos
    distrobox
    gcc
    git
    lm_sensors
    nvidia_oc
    podman
    power-profiles-daemon
    p7zip
    aria2
    unrar
    unzip
  ];

  # Services
  services.flatpak.enable = true;
  services.fwupd.enable = true;

  hardware.bluetooth.enable = true;
}
