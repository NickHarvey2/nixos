{
  enable = true;
  attributes = [
    "*secrets.yaml diff=sopsdiffer"
    "krb5.conf filter=git-crypt diff=git-crypt"
  ];
  extraConfig = {
    diff.sopsdiffer.textconv = "sops -d --config /dev/null";
    push.autoSetupRemove = true;
    pull.rebase = true;
    diff.algorithm = "histogram";
    branch.sort = "-committerdate";
    tag.sort = "-version:refname";
  };
}
