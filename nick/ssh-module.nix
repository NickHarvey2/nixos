{identities, ...}: {
  home = {
    file.pubSshKey = {
      # target = ".ssh/NickHarvey2-id_rsa.pub";
      target = identities.NickHarvey2.identityFile;
      # derived from gpg rsa (authentication) key using `gpg2 --export-ssh-key $kid`
      source = ./NickHarvey2-id_rsa.pub;
    };
  };

  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "nixos2" = {
          match = "User nick Host nixos2";
          hostname = "nixos2.home.arpa";
          inherit (identities.NickHarvey2) identityFile;
          port = 5931;
          localForwards = [
            {
              bind.port = 8080;
              host.address = "127.0.0.1";
              host.port = 8080;
            }
          ];
        };
        "NickHarvey2" = {
          match = "User git Host github.com";
          inherit (identities.NickHarvey2) identityFile;
        };
      };
    };
  };
}
