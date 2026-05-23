{ pkgs, ... }:
{
  users.users.seyrn = {
    isNormalUser = true;
    description = "Seyrn";
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
    ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    aria2
    bat
    eza
    fzf
    unrar
    unzip
  ];

  programs = {
    starship.enable = true;
    zoxide.enable = true;
    zsh.enable = true;
  };
}
