{ ... }:
{
  networking = {
    networkmanager.enable = true;
    nameservers = [               # Sets dns to cloudflare block malware
      "1.1.1.2" "1.0.0.2"
      "2606:4700:4700::1112" "2606:4700:4700::1002"
    ];
    networkmanager.dns = "none";
  };
}
