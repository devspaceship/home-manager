{ ... }:
{
  services.avahi = {
    enable = true;
    nssmdns4 = true; # enables *.local resolution over IPv4 via NSS
    nssmdns6 = true; # IPv6
    openFirewall = true; # opens UDP 5353 in the firewall
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  services.tailscale.enable = true;

  networking = {
    hostName = "home";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      logRefusedPackets = true;
    };
  };
}
