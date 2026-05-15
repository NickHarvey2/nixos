{identities, ...}: {
  programs.git = {
    signing = {
      format = identities.NickHarvey2.keyformat;
      key = identities.NickHarvey2.signingkey;
      signByDefault = true;
    };
    settings = {
      user = {
        name = identities.NickHarvey2.name;
        email = identities.NickHarvey2.email;
      };
    };
  };
}
