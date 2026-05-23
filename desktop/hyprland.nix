{ ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.greetd = {
    settings = {
      initial_session = {
        command = "uwsm start hyprland.desktop";
        user = "seyrn";
      };
    };
  };
}
