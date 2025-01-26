{ pkgs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    users.seyrn =
      { ... }:
      {
        imports = [
          ./helix.nix
          ./alacritty.nix
          ./starship.nix
          ./zsh.nix
        ];
        home = {
          stateVersion = "24.11";
          username = "seyrn";
        };
      };
  };

  users.users.seyrn = {
    home = "/home/seyrn";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  programs.zsh.enable = true;
}
