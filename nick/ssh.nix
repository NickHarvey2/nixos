{identities}: {
  enable = true;
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
      certificateFile = "~/.ssh/id_ed25519-cert_Mortgage-Research-Center.pub";
    };
    "vu-product-development" = {
      match = "User org-158356857 Host github.com";
      identityFile = identities.NickHarveyVu.identityFile;
      certificateFile = "~/.ssh/id_ed25519-cert_vu-product-development.pub";
    };
    "vu-pdt" = {
      match = "User org-158357197 Host github.com";
      identityFile = identities.NickHarveyVu.identityFile;
      certificateFile = "~/.ssh/id_ed25519-cert_vu-pdt.pub";
    };
    "vu-platform" = {
      match = "User org-158358431 Host github.com";
      identityFile = identities.NickHarveyVu.identityFile;
      certificateFile = "~/.ssh/id_ed25519-cert_vu-platform.pub";
    };
    "akamai" = {
      match = "Host *.upload.akamai.com";
      identityFile = identities.NickHarveyVu.identityFile;
    };
  };
}
