{identities, ...}: {
  programs.git = {
    signing = {
      format = "openpgp";
      key = identities.NickHarvey2.signingKey;
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
