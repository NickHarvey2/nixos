{
  services = {
    openssh = {
      enable = true;
      ports = [5931];
      settings = {
        LogLevel = "VERBOSE";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = ["nick"];
      };
    };
    fail2ban.enable = true;
    endlessh = {
      enable = true;
      port = 22;
      openFirewall = true;
    };
  };
}
