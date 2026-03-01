# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  ...
}: {
  # TODO <netbird service reconfigure --service-env NB_DISABLE_SSH_CONFIG=true>
  services.netbird.clients.default = {
    port = 51820;
    name = "netbird";
    interface = "wt0";
    hardened = false;
    environment.NB_DISABLE_SSH_CONFIG = "1";
  };
}
