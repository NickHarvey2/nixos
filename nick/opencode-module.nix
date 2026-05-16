{
  inputs,
  pkgs,
  ...
}:
let
  jailed-agents = inputs.jailed-agents.lib.${pkgs.stdenv.hostPlatform.system};
  combinators = jailed-agents.internals.jail.combinators;
in {
  programs.opencode = {
    enable = true;
    package = jailed-agents.makeJailedOpencode {
      name = "jailed-opencode";
      extraPkgs = with pkgs; [ nodejs python3 ];
      extraReadonlyDirs = [
        "/nix/store"
      ];
      baseJailOptions = jailed-agents.commonJailOptions ++ [
        (combinators.try-fwd-env "XDG_RUNTIME_DIR")
      ];
    };
    enableMcpIntegration = true;
    skills = {
      pdf = "${inputs.anthropic-skills}/skills/pdf";
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
        models = {
          "unsloth/gemma-4-26B-A4B-it-GGUF:Q8_K_XL" = {
            name = "Gemma-4 26B A4B";
          }; 
          "unsloth/gemma-4-31B-it-GGUF:Q8_K_XL" = {
            name = "Gemma-4 31B";
          };
          "unsloth/Qwen3-Coder-Next-GGUF:Q4_K_XL" = {
            name = "Qwen3 Coder Next";
          };
        };
      };
    };
  };
}
