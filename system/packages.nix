{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    distrobox
    gcc
    git
    helix
    lm_sensors
  ];

  # Podman
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  programs.direnv.enable = true;

  # Services
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };
  services.flatpak.enable = true;
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;

  hardware.bluetooth.enable = true;
}
