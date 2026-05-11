{
  programs.git = {
    signing = {
      format = "openpgp";
      key = "8B675B26E0E27514!";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "NickHarveyVu";
        email = "Nick.Harvey@veteransunited.com";
      };
    };
  };
}
