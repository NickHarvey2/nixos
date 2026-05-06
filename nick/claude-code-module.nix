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
      docx = "${inputs.anthropic-skills}/skills/docx";
      pptx = "${inputs.anthropic-skills}/skills/pptx";
      lxsx = "${inputs.anthropic-skills}/skills/lxsx";
      skill-creator = "${inputs.anthropic-skills}/skills/skill-creator";
      theme-factory = "${inputs.anthropic-skills}/skills/theme-factory";
    };
    settings = {};
  };
}
