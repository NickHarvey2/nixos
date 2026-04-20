{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
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
  };

  outputs = {
    # self,
    nixpkgs,
    nixos-wsl,
    home-manager,
    ...
  } @ inputs: let
    hosts = {
      vu-hostname = "VUHL-J9VJKN3";
      nixos1-hostname = "nixos";
      nixos2-hostname = "nixos2";
      nixos3-hostname = "nixos3";
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
                hosts = hosts;
              };
              useUserPackages = true;
              users.nick = {
                imports = [
                  ./nick/shared-packages-module.nix
                  ./nick/nixos1-packages-module.nix
                  ./nick/ssh-module.nix
                  ./nick/tmux-module.nix
                  ./nick/zsh-module.nix
                  ./nick/leadr-module.nix
                  ./nick/gh-module.nix
                  ./nick/git-module.nix
                  ./nick/gpg-module.nix
                  ./nick/rbw-module.nix
                  ./nick/btop-module.nix
                  ./nick/nvim-module.nix
                  ./nick/udiskie-module.nix
                  ./nick/hypr-module.nix
                  ./nick/waybar-battery-module.nix
                  ./nick/suspend-module.nix
                  ./nick/touchpad-toggle-module.nix
                  ./nick/pinentry-rofi.nix
                  ./nick/kitty-module.nix
                  ./nick/firefox-module.nix
                  ./nick/qute-module.nix
                  ./nick/atuin-module.nix
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
                hosts = hosts;
              };
              useUserPackages = true;
              users.nick = {
                imports = [
                  ./nick/shared-packages-module.nix
                  ./nick/nixos2-packages-module.nix
                  ./nick/ssh-module.nix
                  ./nick/tmux-module.nix
                  ./nick/zsh-module.nix
                  ./nick/leadr-module.nix
                  ./nick/gh-module.nix
                  ./nick/git-module.nix
                  ./nick/gpg-module.nix
                  ./nick/rbw-module.nix
                  ./nick/btop-module.nix
                  ./nick/nvim-module.nix
                  ./nick/framework-module.nix
                  ./nick/udiskie-module.nix
                  ./nick/hypr-module.nix
                  ./nick/waybar-nobattery-module.nix
                  ./nick/saver-module.nix
                  ./nick/pinentry-rofi.nix
                  ./nick/kitty-module.nix
                  ./nick/firefox-module.nix
                  ./nick/qute-module.nix
                  ./nick/atuin-module.nix
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
                hosts = hosts;
              };
              useUserPackages = true;
              users.nick = {
                imports = [
                  ./nick/shared-packages-module.nix
                  ./nick/nixos3-packages-module.nix
                  ./nick/ssh-module.nix
                  ./nick/tmux-module.nix
                  ./nick/zsh-module.nix
                  ./nick/leadr-module.nix
                  ./nick/gh-module.nix
                  ./nick/git-module.nix
                  ./nick/gpg-module.nix
                  ./nick/rbw-module.nix
                  ./nick/btop-module.nix
                  ./nick/nvim-module.nix
                  ./nick/framework-module.nix
                  ./nick/udiskie-module.nix
                  ./nick/hypr-module.nix
                  ./nick/waybar-battery-module.nix
                  ./nick/suspend-module.nix
                  ./nick/touchpad-toggle-module.nix
                  ./nick/pinentry-rofi.nix
                  ./nick/kitty-module.nix
                  ./nick/firefox-module.nix
                  ./nick/qute-module.nix
                  ./nick/atuin-module.nix
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

      "${hosts.vu-hostname}" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          nixos-wsl.nixosModules.default
          {
            wsl = {
              enable = true;
              defaultUser = "nick";
              wslConf = {
                user.default = "nick";
                automount.enabled = true;
              };
              usbip = {
                enable = true;
                autoAttach = [
                  "2-1"
                  "2-2"
                  "2-3"
                ];
                snippetIpAddress = "127.0.0.1";
              };
            };
          }

          {
            networking.hostName = hosts.vu-hostname;
          }

          ./wsl-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs;
                hosts = hosts;
              };
              useUserPackages = true;
              users.nick = {
                imports = [
                  ./nick/shared-packages-module.nix
                  ./nick/ssh-module.nix
                  ./nick/tmux-module.nix
                  ./nick/zsh-module.nix
                  ./nick/leadr-module.nix
                  ./nick/gh-module.nix
                  ./nick/git-module.nix
                  ./nick/gpg-module.nix
                  ./nick/rbw-module.nix
                  ./nick/btop-module.nix
                  ./nick/nvim-module.nix
                  ./nick/pinentry-curses.nix
                  ./nick/atuin-module.nix
                  ./nick/semdiff-module.nix
                ];

                home.sessionVariables = {
                  ENTR_INOTIFY_WORKAROUND = 1;
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
  };
}
