{...}: {
  services = {
    unbound = {
      enable = true;
      resolveLocalQueries = false;
      settings = {
        server = {
          # use-syslog = false;
          # logfile = "/tmp/unbound.log";
          verbosity = 0;
          interface = [
            "100.90.219.187"
            "127.0.0.1"
          ];
          port = 7432;
          access-control = [
            "127.0.0.1 allow"
            "100.90.237.100 allow"
            "100.90.219.187 allow"
            "100.90.49.176 allow"
          ];
          harden-glue = true;
          harden-dnssec-stripped = true;
          use-caps-for-id = false;
          prefetch = true;
          edns-buffer-size = 1232;
          hide-identity = true;
          hide-version = true;
          private-address = [
            "192.168.0.0/16"
            "169.254.0.0/16"
            "172.16.0.0/12"
            "10.0.0.0/8"
            "fd00::/8"
            "fe00::/10"
            "192.0.2.0/24"
            "198.51.100.0/24"
            "203.0.113.0/24"
            "255.255.255.255/32"
            "2001:db8::/32"
          ];
          local-data = [
            "'testnetbird83784. TXT \"qwerty\"'"
          ];
        };
        forward-zone = [
          {
            name = ".";
            forward-addr = [
              "9.9.9.9#dns.quad9.net"
              "149.112.112.112#dns.quad9.net"
            ];
            forward-tls-upstream = true;
          }
        ];
      };
    };
    dnsmasq = {
      enable = true;
      settings = {
        interface = "lo";
        listen-address = "127.0.0.1";
        no-resolv = true;
        server = [
          "127.0.0.1#7432"
        ];
        cache-size = 0;
      };
    };
    resolved.enable = false;
  };
  networking.nameservers = [
    "127.0.0.1"
  ];
}
