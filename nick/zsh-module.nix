{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    # zsh-autoenv.enable = true;
    syntaxHighlighting.enable = true;
    initContent =
      # sh
      ''
        function jwt() {
          echo -n $1 | cut -d. -f2 | base64 -d - 2>/dev/null | jq
        }
        function akamai() {
          podman run -it -v $HOME/.edgerc:/root/.edgerc:ro -v .:/workdir:rw akamai/shell:v2.26.0 akamai $@ | tail -n+12
        }
        unalias gau
        which leadr > /dev/null
        if (( $? == 0 )); then
          source <(leadr --zsh)
        fi
        which netbird > /dev/null
        if (( $? == 0 )); then
          source <(netbird completion zsh)
        fi
      '';
    # TODO completions for podman, rancher, gh, rbw, step, dotnet, gum, dig, curl

    shellAliases = {
      rebuild = "$FLAKE_DIR/rebuild.sh";
      pick-account = "$FLAKE_DIR/pick-account.sh";
      ls = "exa";
      ll = "exa -alh";
      tree = "exa --tree";
      n = "nvim .";
      secret = "sops -d $FLAKE_DIR/secrets/secrets.yaml | yq -r ";
      secrets = "yq -r 'keys[]' $FLAKE_DIR/secrets/secrets.yaml";
      picksecret = "echo \".$(secrets | gum choose)\" | { secret $(cat -) }";
      rk = "rancher kubectl";
      scu = "sops -d $FLAKE_DIR/secrets/secrets.yaml > /dev/null"; # add an alias to decrypt sops file and redirect to /dev/null, forcing the smartcard to be unlocked
      vpn = "$FLAKE_DIR/vpn.sh";
      sci = "step certificate inspect --format=json --insecure";
      decolorize = "sed 's/\\x1B\\[[0-9;]*[A-Za-z]//g'";
      pick-sha = "git log --oneline --no-abbrev-commit | gum choose | cut -f1 -d' '";
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
  };
}
