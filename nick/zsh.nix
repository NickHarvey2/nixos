{
  enable = true;
  enableCompletion = true;
  # autosuggestions.enable = true;
  # zsh-autoenv.enable = true;
  syntaxHighlighting.enable = true;
  initExtra = ''
    function tls() {
      echo | openssl s_client -showcerts -servername $1 -connect $1:443 2>/dev/null | step certificate inspect - --format json | jq $2
    }
    function jwt() {
      echo -n $1 | cut -d. -f2 | base64 -d - 2>/dev/null | jq
    }
    unalias gau
  '';

  shellAliases = {
    rebuild = "$FLAKE_DIR/rebuild.sh";
    pick-account = "$FLAKE_DIR/pick-account.sh";
    wifi = "$FLAKE_DIR/wifi.sh";
    copylast = "fc -ln -1 | wl-copy";
    ls = "exa";
    ll = "exa -alh";
    tree = "exa --tree";
    sudolast = "sudo $(fc -ln -1)";
    bwu = "export BW_SESSION=$(bw unlock --raw)";
    bwl = "bw lock";
    n = "nvim .";
    secret = "sops -d $FLAKE_DIR/secrets/secrets.yaml | yq -r ";
    rk = "rancher kubectl";
    scu = "sops -d $FLAKE_DIR/secrets/secrets.yaml > /dev/null"; # add an alias to decrypt sops file and redirect to /dev/null, forcing the smartcard to be unlocked
    bws = "bw list items | jq -r '.[] | \"\(.name),\(.login.username),\(.login.password)\"' | fzf --with-nth=1..2 --delimiter=',' | cut -d',' -f3 | wl-copy";
  };

  oh-my-zsh = {
    enable = true;
    theme = "robbyrussell";
    plugins = [
      "git"
      "history"
      "kubectl"
    ];
  };
}
