{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plugin-gp-nvim = {
      url = "github:robitx/gp.nvim?ref=v3.9.0";
      flake = false;
    };
    plugin-haunt-nvim = {
      url = "github:TheNoeTrevino/haunt.nvim?ref=v0.8.1";
      flake = false;
    };
    leadr = {
      url = "github:ll-nick/leadr?ref=v2.6.0";
      flake = false;
    };
    qute-catppuccin = {
      url = "github:catppuccin/qutebrowser";
      flake = false;
    };
    jailed-agents.url = "github:andersonjoseph/jailed-agents/main";
    semdiff.url = "github:Ataraxy-Labs/sem?ref=v0.3.20";
    anthropic-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };
  };

  outputs = {
    # self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    hosts = {
      vu-hostname = "VUHL-J9VJKN3";
      nixos1-hostname = "nixos";
      nixos2-hostname = "nixos2";
      nixos3-hostname = "nixos3";
    };
    desktopModules = [
      ./nick/udiskie-module.nix
      ./nick/hypr-module.nix
      ./nick/pinentry-rofi.nix
      ./nick/kitty-module.nix
      ./nick/firefox-module.nix
      ./nick/qute-module.nix
    ];
    terminalModules = [
      ./nick/nix-index-module.nix
      ./nick/semdiff-module.nix
      ./nick/atuin-module.nix
      ./nick/nvim-module.nix
      ./nick/btop-module.nix
      ./nick/rbw-module.nix
      ./nick/gpg-module.nix
      ./nick/git-module.nix
      ./nick/gh-module.nix
      ./nick/leadr-module.nix
      ./nick/zsh-module.nix
      ./nick/tmux-module.nix
      ./nick/shared-packages-module.nix
    ];
    identities = {
      NickHarvey2 = {
        name = "NickHarvey2";
        email = "NickHarvey2@proton.me";
        identityFile = "~/.ssh/NickHarvey2-id_rsa.pub";
        signingkey = "8B675B26E0E27514";
        keyformat = "openpgp";
      };
    };
  in {
    nixosConfigurations = {
      "${hosts.nixos1-hostname}" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          {
            networking.hostName = hosts.nixos1-hostname;
            boot.kernelParams = ["snd-intel-dspcfg.dsp_driver=1"]; # Required for audio
          }

          ./configuration.nix
          ./netbird.nix
          ./${hosts.nixos1-hostname}-hardware-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs;
                identities = identities;
              };
              useUserPackages = true;
              users.nick = {
                imports = desktopModules ++ terminalModules ++ [
                  ./nick/nixos1-packages-module.nix
                  ./nick/suspend-module.nix
                  ./nick/waybar-battery-module.nix
                  ./nick/touchpad-toggle-module.nix
                  ./nick/ssh-module.nix
                ];

                home.sessionVariables = {
                  FLAKE_DIR = "/home/nick/nixos";
                };

                nixpkgs.config.allowUnfree = true;
                home.stateVersion = "23.11";
              };
            };
          }
        ];
      };

      "${hosts.nixos2-hostname}" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          {
            networking.hostName = hosts.nixos2-hostname;
            services.fwupd.enable = true;
          }

          ./configuration.nix
          ./netbird.nix
          ./unbound.nix
          ./sshd.nix
          ./llama-cpp.nix
          ./${hosts.nixos2-hostname}-hardware-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs;
                identities = identities;
              };
              useUserPackages = true;
              users.nick = {
                imports = desktopModules ++ terminalModules ++ [
                  ./nick/nixos2-packages-module.nix
                  ./nick/saver-module.nix
                  ./nick/waybar-nobattery-module.nix
                  ./nick/framework-module.nix
                  ./nick/ssh-module.nix
                ];

                home.sessionVariables = {
                  FLAKE_DIR = "/home/nick/nixos";
                };

                nixpkgs.config.allowUnfree = true;
                home.stateVersion = "23.11";
              };
            };
          }
        ];
      };

      "${hosts.nixos3-hostname}" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          {
            networking.hostName = hosts.nixos3-hostname;
            services.fwupd.enable = true;
            swapDevices = [
              {
                device = "/var/lib/swapfile";
                size = 48 * 1024; # 48 GB
              }
            ];
          }

          ./configuration.nix
          ./netbird.nix
          ./nvidia.nix
          ./${hosts.nixos3-hostname}-hardware-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs;
                identities = identities;
              };
              useUserPackages = true;
              users.nick = {
                imports = desktopModules ++ terminalModules ++ [
                  ./nick/nixos3-packages-module.nix
                  ./nick/suspend-module.nix
                  ./nick/waybar-battery-module.nix
                  ./nick/touchpad-toggle-module.nix
                  ./nick/framework-module.nix
                  ./nick/ssh-module.nix
                ];

                home.sessionVariables = {
                  FLAKE_DIR = "/home/nick/nixos";
                };

                nixpkgs.config.allowUnfree = true;
                home.stateVersion = "23.11";
              };
            };
          }
        ];
      };
    };
    lib = {
      terminalModules = terminalModules;
      nickHarvey2-pubkey = builtins.readFile ./nick/NickHarvey2-id_rsa.pub;
    };
  };
}
