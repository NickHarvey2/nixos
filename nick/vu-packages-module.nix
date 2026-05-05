{pkgs, ...}: {
  home.packages = with pkgs; [
    syft
    grype
    grafana-loki
    kubectl
    vault
    rancher
    mongosh
  ];
}
