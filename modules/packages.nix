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
    git.enable = true;
    direnv.enable = true;
  };

  # Services
  services = {
    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };
    flatpak.enable = true;
    fwupd.enable = false;
    tuned.enable = true;
  };

  hardware.bluetooth.enable = true;
}
