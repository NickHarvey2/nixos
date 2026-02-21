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
      text = ''
        ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDpTYNMvVq/vr7ws7MUdSKoGzDYx53Vvh8FKxeGZm2TUGjIkTRuacwdRMB1cBxwvKHkhxJp8/citR41sUbOADC4gQb/9fRGgaVuZ8NdPbN6LOeN2mJOSqOurUEVbIxGn6nIrB53JfLtzm97GtwyQ53QrMulASDU1iyaT9OPdUgpZpN3K/YgTzVLiybMfpItS0XqIUmJfnNWSaPsaokQ4mMHsO0sXA9k3VXHwH+ivNYLyjLih0YfJKunkhxoGRXthnRd1IhWSNYC0RhkOKOfWIYDC+FZY5/eyt8drX0rxBjazAs0DpkVAoeuFLcUKdkcCbL+a7nU1tFpr2F7bgh7pPaxpebHJLoUyCnLLBRkaxPyVMta93KOlbucwttw32kXAAFJ08QuaGzIHmwQC5crCq37dbvHW+owabFwTTyI0zg70WGxffyiJEAVUGXo6wVSEwv0MWeoQN6z0VaVhDKc/JcRr30werGbWf0MUY6xwCiOSCHQ9PVQE49QUKnnhI/wdwMl9B+knuvsP5H1MmU9sf2FX1hBbtGlVFn5c/wp85UTJSF0hcQelFWzJtHxZGAe6uCFEE/HykxoKn/SOvqlZk7gT80Glf/B3ECT6EbAj1yph1mPdG6gVQml6+wq2yXC0G9NO1QVCxCK+HQj8fDNYnZZlUTAOBwXbngjaqqJ+e9QtQ== openpgp:0xF0EAB9BC
      '';
    };
  };

  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "gitlab.redchimney.com" = {
          match = "User git Host gitlab.redchimney.com";
          identityFile = identities.NickHarveyVu.identityFile;
        };
        "NickHarvey2" = {
          match = "User git Host github.com";
          identityFile = identities.NickHarvey2.identityFile;
        };
        "Mortgage-Research-Center" = {
          match = "User org-134439726 Host github.com";
          identityFile = identities.NickHarveyVu.identityFile;
          # certificateFile = "~/.ssh/id_ed25519-cert_Mortgage-Research-Center.pub";
        };
        "vu-product-development" = {
          match = "User org-158356857 Host github.com";
          identityFile = identities.NickHarveyVu.identityFile;
          # certificateFile = "~/.ssh/id_ed25519-cert_vu-product-development.pub";
        };
        "vu-pdt" = {
          match = "User org-158357197 Host github.com";
          identityFile = identities.NickHarveyVu.identityFile;
          # certificateFile = "~/.ssh/id_ed25519-cert_vu-pdt.pub";
        };
        "vu-platform" = {
          match = "User org-158358431 Host github.com";
          identityFile = identities.NickHarveyVu.identityFile;
          # certificateFile = "~/.ssh/id_ed25519-cert_vu-platform.pub";
        };
        "akamai" = {
          match = "Host *.upload.akamai.com";
          identityFile = identities.NickHarveyVu.identityFile;
        };
      };
    };
  };
}
