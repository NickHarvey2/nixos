{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plugin-gp-nvim = {
      url = "github:robitx/gp.nvim?ref=v2.4.9";
      flake = false;
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    # self,
    nixpkgs,
    nixos-wsl,
    home-manager,
    ...
  } @ inputs: let
    vu-hostname = "VUHL-J9VJKN3";
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          {
            networking.hostName = "nixos";
          }

          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs;};
              useUserPackages = true;
              users.nick = import ./nick/home.nix;
            };
          }
        ];
      };

      "${vu-hostname}" = nixpkgs.lib.nixosSystem {
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
            networking.hostName = vu-hostname;
          }

          ./wsl-configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs;};
              useUserPackages = true;
              users.nick = import ./nick/home.nix;
            };
          }
        ];
      };
    };
  };
}
