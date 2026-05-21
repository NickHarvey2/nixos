{
  inputs,
  pkgs,
  models,
  ...
}: let
  jailed-agents = inputs.jailed-agents.lib.${pkgs.stdenv.hostPlatform.system};
  combinators = jailed-agents.internals.jail.combinators;
  attrsToRemoveForOpencode = [
    "hf-repo"
    "hf-file"
    "alias"
    "name"
    "c"
    "cache-type-k"
    "cache-type-v"
    "context-shift"
    "fit"
    "seed"
    "temp"
    "top-p"
    "min-p"
    "top-k"
    "jinja"
  ];
in {
  programs.opencode = {
    enable = true;
    package = jailed-agents.makeJailedOpencode {
      name = "jailed-opencode";
      extraPkgs = with pkgs; [
        nodejs
        python3
        python315Packages.pytest
        poppler-utils
        uv
        dotnet-sdk_10
        nix
      ];
      extraReadonlyDirs = [
        "/nix/store"
      ];
      baseJailOptions =
        jailed-agents.commonJailOptions
        ++ [
          (combinators.try-fwd-env "XDG_RUNTIME_DIR")
        ];
    };
    enableMcpIntegration = true;
    skills = {
      pdf = "${inputs.anthropic-skills}/skills/pdf";
      docx = "${inputs.anthropic-skills}/skills/docx";
      mcp-builder = "${inputs.anthropic-skills}/skills/mcp-builder";
      skill-creator = "${inputs.anthropic-skills}/skills/skill-creator";
    };
    settings = {
      autoupdate = false;
      theme = "catppuccin-frappe";
      model = "unsloth/gemma-4-26B-A4B-it-GGUF:Q8_K_XL";
      provider.llama-cpp = {
        name = "llama.cpp";
        npm = "@ai-sdk/openai-compatible";
        options = {
          baseURL = "http://127.0.0.1:8080/v1";
        };
        models = builtins.mapAttrs (k: v: removeAttrs v attrsToRemoveForOpencode) models;
      };
    };
  };
}
