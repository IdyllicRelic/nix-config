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
    fzf
    unrar
    unzip
  ];

  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.zsh.enable = true;
}
