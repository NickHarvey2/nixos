{
  enable = true;
  attributes = [
    "*secrets.yaml diff=sopsdiffer"
    "krb5.conf filter=git-crypt diff=git-crypt"
  ];
  extraConfig = {
    diff.sopsdiffer.textconv = "sops -d --config /dev/null";
  };
}
