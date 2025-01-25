{ ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "rose_pine";
      editor = {
        bufferline = "multiple";
        cursorline = true;
        true-color = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          character = "╎";
          render = true;
        };
        lsp = {
          auto-signature-help = false;
          display-messages = true;
        };
        statusline = {
          left = [ "mode" "spinner" "version-control" "file-name" ];
        };
      };
    };
    languages = {
      language-server = {
        nixd = {
          command = "nixd";
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "nixfmt";
          language-servers = [ "nixd" ];
          file-types = [ "nix" ];
        }
      ];
    };
  };
}
