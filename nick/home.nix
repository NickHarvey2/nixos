{
  inputs,
  pkgs,
  lib,
  osConfig,
  hosts,
  hyprland_kb_opts,
  extra_packages,
  ...
}: let
  identities = {
    NickHarvey2 = {
      email = "NickHarvey2@proton.me";
      identityFile = "~/.ssh/NickHarvey2-id_rsa.pub";
      signingkey = "8B675B26E0E27514";
      keyformat = "gpg";
    };
    NickHarveyVu = {
      email = "Nick.Harvey@veteransunited.com";
      identityFile = "~/.ssh/NickHarveyVu-id_rsa";
      signingkey = "~/.ssh/NickHarveyVu-id_rsa";
      keyformat = "ssh";
    };
  };
in {
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
      leadr = prev.rustPlatform.buildRustPackage {
        pname = "leadr";
        version = "2.6.0";
        cargoLock.lockFile = inputs.leadr + "/Cargo.lock";
        src = inputs.leadr;
        meta = with pkgs.lib; {
          description = "A customizable CLI command manager inspired by the leader key concept in (Neo)Vim";
          license = licenses.mit;
          homepage = "https://github.com/ll-nick/leadr";
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
      btop
      obsidian
      croc
      asciinema
      catdocx
      catdoc
      nixos-generators
      d2
      parallel
      xan
      dust
      fastfetch
      discord

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

      # security tools
      syft
      grype
      step-cli
      gau
      bitwarden-cli
      openssl
      pass
      pinentry-tty
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
      leadr
      ncdu

      # admin tools
      kubectl
      vault
      rancher

      # tmux plugins
      tmuxPlugins.sensible
      tmuxPlugins.catppuccin
      tmuxPlugins.battery

      # runtimes/compilers + dev tools
      libgcc
      gcc
      pkg-config
      dotnet-sdk_8
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
      diff-so-fancy
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
        openscad
        openscad-lsp
        bambu-studio
        fw-ectool
      ]
    )
    # only install these on nixos3
    (
      lib.mkIf (osConfig.networking.hostName == hosts.nixos3-hostname) [
        fw-ectool
      ]
    )
  ];

  home = {
    sessionVariables = {
      ENTR_INOTIFY_WORKAROUND = 1;
      FLAKE_DIR = "/home/nick/nixos";
      IDENTITIES_FILE = builtins.toFile "json" (builtins.toJSON identities);
    };
    file.pubSshKey = {
      target = ".ssh/NickHarvey2-id_rsa.pub";
      # derived from gpg rsa (authentication) key using `gpg2 --export-ssh-key $kid`
      text = ''
        ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDpTYNMvVq/vr7ws7MUdSKoGzDYx53Vvh8FKxeGZm2TUGjIkTRuacwdRMB1cBxwvKHkhxJp8/citR41sUbOADC4gQb/9fRGgaVuZ8NdPbN6LOeN2mJOSqOurUEVbIxGn6nIrB53JfLtzm97GtwyQ53QrMulASDU1iyaT9OPdUgpZpN3K/YgTzVLiybMfpItS0XqIUmJfnNWSaPsaokQ4mMHsO0sXA9k3VXHwH+ivNYLyjLih0YfJKunkhxoGRXthnRd1IhWSNYC0RhkOKOfWIYDC+FZY5/eyt8drX0rxBjazAs0DpkVAoeuFLcUKdkcCbL+a7nU1tFpr2F7bgh7pPaxpebHJLoUyCnLLBRkaxPyVMta93KOlbucwttw32kXAAFJ08QuaGzIHmwQC5crCq37dbvHW+owabFwTTyI0zg70WGxffyiJEAVUGXo6wVSEwv0MWeoQN6z0VaVhDKc/JcRr30werGbWf0MUY6xwCiOSCHQ9PVQE49QUKnnhI/wdwMl9B+knuvsP5H1MmU9sf2FX1hBbtGlVFn5c/wp85UTJSF0hcQelFWzJtHxZGAe6uCFEE/HykxoKn/SOvqlZk7gT80Glf/B3ECT6EbAj1yph1mPdG6gVQml6+wq2yXC0G9NO1QVCxCK+HQj8fDNYnZZlUTAOBwXbngjaqqJ+e9QtQ== openpgp:0xF0EAB9BC
      '';
    };
    file.commonConf = {
      # By default this file is created with keyboxd set to be enabled
      # So create an empty file to prevent this
      target = ".gnupg/common.conf";
      text = "";
    };
    file.hyprpaper = {
      target = ".config/hypr/hyprpaper.conf";
      source = ./hyprpaper.conf;
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
      source = ./config.mako;
    };
    file.waybarConf = {
      target = ".config/waybar/config.jsonc";
      source = ./waybar.config.jsonc;
    };
    file.waybarStyle = {
      target = ".config/waybar/style.css";
      source = ./waybar.style.css;
    };
    file.btopConf = {
      target = ".config/btop/btop.conf";
      source = ./btop.conf;
    };
    file.btopTheme = {
      target = ".config/btop/themes/catppuccin_frappe.theme";
      source = ./btop_catppuccin_frappe.theme;
    };
    file.leadrConfig = {
      target = ".config/leadr/config.toml";
      source = ./leadr.config.toml;
    };
    file.leadrMappings = {
      target = ".config/leadr/mappings.toml";
      source = ./leadr.mappings.toml;
    };
    file.toggleTouchpad = {
      target = "touchpad-toggle.sh";
      source = ./touchpad-toggle.sh;
      executable = true;
    };
    file.cmdListen = {
      target = "cmdlisten.sh";
      source = ./cmdlisten.sh;
      executable = true;
    };
    activation = {
      mkFifoPipe = lib.hm.dag.entryAfter ["writeBoundary"]
      # sh
      ''
        if [[ $(ls pipe 2>/dev/null | wc -l) == 0 ]]; then
          echo 'creating fifo "pipe"'
          mkfifo pipe
        else
          echo 'fifo "pipe" already exists; skipping creation'
        fi
      '';
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = import ./hyprland.nix {lib = lib; kb_opts = hyprland_kb_opts;};
  };

  programs = {
    tmux = import ./tmux.nix {pkgs = pkgs;};
    zsh = import ./zsh.nix;
    ssh = import ./ssh.nix {identities = identities;};
    neovim = import ./nvim.nix {pkgs = pkgs;};
    gh = import ./gh.nix;
    gpg = import ./gpg.nix;
    git = import ./git.nix;
    kitty = import ./kitty.nix {pkgs = pkgs;};
    firefox = import ./firefox.nix {inputs = inputs; pkgs = pkgs;};
  };

  services = {
    gpg-agent = import ./gpg-agent.nix {pkgs = pkgs;};
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";
}
