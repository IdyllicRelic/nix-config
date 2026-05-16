{ pkgs, ... }:
{
  imports = [
    ./user.nix
    ./noctalia.nix
  ];

  home.username = "seyrn";
  home.homeDirectory = "/home/seyrn";
  home.stateVersion = "24.11";
}
