{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    helix
    nixd
    nixfmt
    podman-compose
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

  programs = {
    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };
    git.enable = true;
  };

  # Services
  services = {
    flatpak.enable = true;
    fwupd.enable = false;
    scx = {
      enable = true;
      scheduler = "scx_cake";
    };
    power-profiles-daemon.enable = true;
    undervolt = {
      enable = true;
      coreOffset = -100;
      gpuOffset = -100;
    };
  };

  hardware.bluetooth.enable = true;
}
