{
  enable = true;
  # disable ccid on scdaemon so it doesn't conflict with pcscd
  scdaemonSettings.disable-ccid = true;
  publicKeys = [
    {
      source = ./public_key;
      trust = 5;
    }
  ];
}
