let
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
  home = {
    sessionVariables = {
      IDENTITIES_FILE = builtins.toFile "json" (builtins.toJSON identities);
    };
    file.pubSshKey = {
      target = ".ssh/NickHarvey2-id_rsa.pub";
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
        "gitlab.redchimney.com" = {
          match = "User git Host gitlab.redchimney.com";
          inherit (identities.NickHarveyVu) identityFile;
        };
        "NickHarvey2" = {
          match = "User git Host github.com";
          inherit (identities.NickHarvey2) identityFile;
        };
        "Mortgage-Research-Center" = {
          match = "User org-134439726 Host github.com";
          inherit (identities.NickHarveyVu) identityFile;
          # certificateFile = "~/.ssh/id_ed25519-cert_Mortgage-Research-Center.pub";
        };
        "vu-product-development" = {
          match = "User org-158356857 Host github.com";
          inherit (identities.NickHarveyVu) identityFile;
          # certificateFile = "~/.ssh/id_ed25519-cert_vu-product-development.pub";
        };
        "vu-pdt" = {
          match = "User org-158357197 Host github.com";
          inherit (identities.NickHarveyVu) identityFile;
          # certificateFile = "~/.ssh/id_ed25519-cert_vu-pdt.pub";
        };
        "vu-platform" = {
          match = "User org-158358431 Host github.com";
          inherit (identities.NickHarveyVu) identityFile;
          # certificateFile = "~/.ssh/id_ed25519-cert_vu-platform.pub";
        };
        "akamai" = {
          match = "Host *.upload.akamai.com";
          inherit (identities.NickHarveyVu) identityFile;
        };
      };
    };
  };
}
