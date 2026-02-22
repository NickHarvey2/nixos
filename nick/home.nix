{
  inputs,
  pkgs,
  lib,
  osConfig,
  hosts,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      # overlay to make otherwise unpackaged neovim plugins available on vimPlugins
      vimPlugins =
        prev.vimPlugins
        // {
          gp-nvim = prev.vimUtils.buildVimPlugin {
            name = "gp";
            src = inputs.plugin-gp-nvim;
          };
        };
    })
  ];

  nixpkgs.config.allowUnfree = true;
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
      rofi-power-menu
      rofi-network-manager
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
      rofi-rbw-wayland

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
      luajit
      luajitPackages.luarocks
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

      # neovim stuff
      tree-sitter

      # language servers
      nixd
      gopls
      lua-language-server
      omnisharp-roslyn
      vscode-langservers-extracted
      terraform-ls
    ]
    # only install these on nixos2
    (
      lib.mkIf (osConfig.networking.hostName == hosts.nixos2-hostname) [
        llama-cpp
      ]
    )
  ];

  home = {
    sessionVariables = {
      ENTR_INOTIFY_WORKAROUND = 1;
      FLAKE_DIR = "/home/nick/nixos";
    };
    file.commonConf = {
      # By default this file is created with keyboxd set to be enabled
      # So create an empty file to prevent this
      target = ".gnupg/common.conf";
      text = "";
    };
    file.hyprlock = {
      target = ".config/hypr/hyprlock.conf";
      source = ./hyprlock.conf;
    };
    file.hypridle = {
      target = ".config/hypr/hypridle.conf";
      source = ./hypridle.conf;
    };
    file.rofi = {
      target = ".config/rofi/config.rasi";
      source = ./config.rasi;
    };
    file.mako = {
      target = ".config/mako/config";
      text = "";
    };
    file.waybarConf = {
      target = ".config/waybar/config.jsonc";
      source = ./waybar.config.jsonc;
    };
    file.waybarStyle = {
      target = ".config/waybar/style.css";
      source = ./waybar.style.css;
    };
    file.toggleTouchpad = {
      target = "touchpad-toggle.sh";
      source = ./touchpad-toggle.sh;
      executable = true;
    };
    # example activation script:
    # activation = {
    #   mkFifoPipe = lib.hm.dag.entryAfter ["writeBoundary"]
    #   # sh
    #   ''
    #     if [[ $(ls pipe 2>/dev/null | wc -l) == 0 ]]; then
    #       echo 'creating fifo "pipe"'
    #       mkfifo pipe
    #     else
    #       echo 'fifo "pipe" already exists; skipping creation'
    #     fi
    #   '';
    # };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = import ./hyprland.nix;
  };

  programs = {
    neovim = import ./nvim.nix {pkgs = pkgs;};
  };

  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = "~/background";
        wallpaper = ", ~/background";
      };
    };
  };
}
