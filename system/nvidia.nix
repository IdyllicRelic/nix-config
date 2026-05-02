{ config, pkgs, ... }:
{
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    open = true;
    dynamicBoost.enable = true;
  };
  hardware.nvidia.prime = {
    offload.enable = true;
    offload.enableOffloadCmd = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
}
