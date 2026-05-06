{
  inputs,
  pkgs,
  ...
}: {
  programs.claude-code = {
    enable = true;
    package = inputs.jailed-agents.lib.${pkgs.stdenv.hostPlatform.system}.makeJailedClaudeCode {
      name = "jailed-claude";
      extraPkgs = with pkgs; [ nodejs python3 ];
      extraReadonlyDirs = [ "/nix/store" ];
    };
    enableMcpIntegration = true;
    marketplaces = {};
    skills = {
      pdf = "${inputs.anthropic-skills}/skills/pdf";
    };
    settings = {};
  };
}
