{
  inputs,
  pkgs,
  lib,
  osConfig,
  hosts,
  ...
}: {
  home.packages = with pkgs; lib.mkMerge [
    [
      unzip
      zip
      wl-clipboard
      zk
      git-crypt
      gocryptfs
      termusic
      cava
      lsof
      yazi
      zenith-nvidia
      obsidian
      catdocx
      catdoc
      nixos-generators
      d2
      parallel
      xan
      dust
      fastfetch
      discord
      terminal-toys

      # container tools
      podman-tui
      podman-compose
      dive

      # networking tools
      traceroute
      whois
      dig
      wget
      mapcidr
      unixtools.ifconfig

      # security tools
      syft
      grype
      step-cli
      gau
      openssl
      pass
      yubikey-manager
      sops
      sslscan

      # cli tools
      jq
      fx
      yq
      fd
      fzf
      eza
      bat
      ripgrep
      grafana-loki
      ncdu

      # admin tools
      kubectl
      vault
      rancher

      # runtimes/compilers + dev tools
      libgcc
      gcc
      pkg-config
      dotnet-sdk_10
      go
      go-tools
      zig
      python3
      nodejs_20
      just
      sqlite
      alejandra
      gum
      entr
      lazygit
      sqlite
      powershell
      opentofu
      conftest
      mongosh
      delta
      clang-tools
      bear
    ]
    # only install these on nixos2
    (
      lib.mkIf (osConfig.networking.hostName == hosts.nixos2-hostname) [
        llama-cpp
      ]
    )
  ];

  home.sessionVariables = {
    ENTR_INOTIFY_WORKAROUND = 1;
    FLAKE_DIR = "/home/nick/nixos";
  };
}
