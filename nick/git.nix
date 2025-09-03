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
    alias = {
      graph = "log --all --graph --decorate --oneline";
      l = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      ignore = "!gi() { local IFS=','; curl -sL https://www.toptal.com/developers/gitignore/api/\"$*\"; }; gi";
      list-ignore = "!gi() { curl -sL \"https://www.toptal.com/developers/gitignore/api/$(curl -sL https://www.toptal.com/developers/gitignore/api/list | tr ',' '\n' | gum filter --no-limit | xargs echo -n | tr ' ' ',')\"; }; gi";
    };
  };
}
