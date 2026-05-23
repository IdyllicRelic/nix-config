{ config, pkgs, ... }:
{
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  environment.systemPackages = with pkgs; [
    nvidia_oc
  ];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      open = true;
      dynamicBoost.enable = true;
      powerManagement.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
      };
    };
    nvidia-container-toolkit.enable = true; # Podman GPU Support
    graphics = {
      enable = true;
      extraPackages = with pkgs; [ intel-media-driver ];
    };
  };

  # Automatic nvidia overclocking
  systemd.services.nvidia_oc = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "NVIDIA Overclocking Service";
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/nvidia_oc set --index 0 --freq-offset 180 --mem-offset 360";
      User = "root";
      Restart = "on-failure";
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
