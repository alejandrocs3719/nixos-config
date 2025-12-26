{
  # for security reasons, only open the following ports to the network by default.
  networking.firewall.allowedTCPPorts = [
    # Localsend
    #53317
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}