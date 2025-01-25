{ ... }:
{
  programs.zsh = {
    enable = true;
    initExtra = ''
      source ./.zshrc
    '';
  };
}
