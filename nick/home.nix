{
  inputs,
  pkgs,
  ...
}: let
  identities = {
    NickHarvey2 = {
      email = "NickHarvey2@proton.me";
      identityFile = "~/.ssh/NickHarvey2-id_rsa.pub";
      signingkey = "8B675B26E0E27514!";
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
    # overlay to make otherwise unpackaged neovim plugins available on vimPlugins
    (final: prev: {
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
  home.packages = with pkgs; [
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

    # container tools
    podman-tui
    podman-compose
    dive

    # networking tools
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
    yq
    fd
    fzf
    eza
    bat
    ripgrep
    grafana-loki

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

    # neovim stuff
    tree-sitter

    # language servers
    nixd
    gopls
    lua-language-server
    omnisharp-roslyn
    vscode-langservers-extracted
  ];

  home = {
    sessionVariables = {
      ENTR_INOTIFY_WORKAROUND = 1;
      FLAKE_DIR = "/home/nick/nixos";
      IDENTITIES_FILE = builtins.toFile "json" (builtins.toJSON identities);
      NNN_FIFO = "/tmp/nnn.fifo";
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
    file.hyprland = {
      target = ".config/hypr/hyprland.conf";
      source = ./hyprland.conf;
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
