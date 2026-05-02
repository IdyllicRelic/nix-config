{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ananicy-rules-cachyos
    distrobox
    gcc
    git
    lm_sensors
    nvidia_oc
    p7zip
    aria2
    unrar
    unzip
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
  services.ananicy-cpp.enable = true;
  services.flatpak.enable = true;
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;

  hardware.bluetooth.enable = true;
}
