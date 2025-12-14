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
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    leadr = {
      url = "github:ll-nick/leadr?ref=v2.6.0";
      flake = false;
    };
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
          }

          ./configuration.nix

          ./${hosts.nixos1-hostname}-hardware-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs; hosts = hosts; hyprland_kb_opts = "caps:swapescape";};
              useUserPackages = true;
              users.nick = import ./nick/home.nix;
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
          }

          ./configuration.nix

          ./${hosts.nixos2-hostname}-hardware-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs; hosts = hosts; hyprland_kb_opts = "";};
              useUserPackages = true;
              users.nick = import ./nick/home.nix;
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
          }

          ./configuration.nix

          ./${hosts.nixos3-hostname}-hardware-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs; hosts = hosts; hyprland_kb_opts = "caps:swapescape";};
              useUserPackages = true;
              users.nick = import ./nick/home.nix;
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
              extraSpecialArgs = {inherit inputs; hosts = hosts; hyprland_kb_opts = "";};
              useUserPackages = true;
              users.nick = import ./nick/home.nix;
            };
          }
        ];
      };
    };
  };
}
