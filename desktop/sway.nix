{ pkgs, ... }:
{
  environment.sessionVariables = {
    WLR_DRM_DEVICES = "/dev/dri/by-name/igpu";
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = [ ];
    package = pkgs.swayfx;
  };

  services.greetd = {
    settings = {
      initial_session = {
        command = "${pkgs.swayfx}/bin/sway";
        user = "seyrn";
      };
    };
  };
}
