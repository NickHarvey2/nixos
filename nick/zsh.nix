{
  enable = true;
  enableCompletion = true;
  # autosuggestions.enable = true;
  # zsh-autoenv.enable = true;
  syntaxHighlighting.enable = true;
  initExtra = ''
    function jwt() {
      echo -n $1 | cut -d. -f2 | base64 -d - 2>/dev/null | jq
    }
    function akamai() {
      podman run -it -v $HOME/.edgerc:/root/.edgerc:ro -v .:/workdir:rw akamai/shell:v2.26.0 akamai $@ | tail -n+12
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
    bws = "$FLAKE_DIR/bws.sh";
    vpn = "$FLAKE_DIR/vpn.sh";
    sci = "step certificate inspect --format=json --insecure";
    decolorize = "sed 's/\\x1B\\[[0-9;]*[A-Za-z]//g'";
    pick-sha = "git log --oneline | gum choose | cut -f1 -d' '";
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
