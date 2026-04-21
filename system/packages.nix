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
    # p7zip
    # helix
    # aria2
    # bat
    # fzf
    # starship
    # unrar
    # unzip
    # zoxide
  ];

  # Services
  services.flatpak.enable = true;

  hardware.bluetooth.enable = true;
}
