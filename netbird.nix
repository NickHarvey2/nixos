{
  services.netbird.clients.default = {
    port = 51820;
    name = "netbird";
    interface = "wt0";
    hardened = false;
    environment.NB_DISABLE_SSH_CONFIG = "1";
  };
}
