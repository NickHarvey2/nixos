{pkgs, ...}: {
  hardware.amdgpu.opencl.enable = true;
  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp-rocm;
    port = 8080;
    host = "127.0.0.1";
    extraFlags = [ "-ngl" "999" "--flash-attn" "on"];
    modelsPreset = {
      "unsloth/Qwen3-Coder-Next-GGUF:Q4_K_XL" = {
        hf-repo = "unsloth/Qwen3-Coder-Next-GGUF";
        hf-file = "Qwen3-Coder-Next-UD-Q4_K_XL.gguf";
        alias = "unsloth/Qwen3-Coder-Next";
        c = "131072";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        context-shift = true;
        fit = "on";
        seed = "3407";
        temp = "1.0";
        top-p = "0.95";
        min-p = "0.01";
        top-k = "40";
        jinja = "on";
      };
      "unsloth/gpt-oss-20b-GGUF:Q8_K_XL" = {
        hf-repo = "unsloth/gpt-oss-20b-GGUF";
        hf-file = "gpt-oss-20b-UD-Q8_K_XL.gguf";
        alias = "unsloth/gpt-oss-20b";
        c = "131072";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        context-shift = true;
        fit = "on";
        seed = "3407";
        temp = "1.0";
        top-p = "0.95";
        min-p = "0.01";
        top-k = "40";
        jinja = "on";
      };
      "unsloth/Qwen3.5-35B-A3B-GGUF:Q8_K_XL" = {
        hf-repo = "unsloth/Qwen3.5-35B-A3B-GGUF";
        hf-file = "Qwen3.5-35B-A3B-UD-Q8_K_XL.gguf";
        alias = "unsloth/Qwen3.5-35B-A3B";
        c = "65536";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        context-shift = true;
        fit = "on";
        seed = "3407";
        temp = "1.0";
        top-p = "0.95";
        min-p = "0.01";
        top-k = "40";
        jinja = "on";
      };
      "unsloth/DeepSeek-R1-Distill-Llama-70B-GGUF:Q5_K_XL" = {
        hf-repo = "unsloth/DeepSeek-R1-Distill-Llama-70B-GGUF";
        hf-file = "DeepSeek-R1-Distill-Llama-70B-UD-Q5_K_XL.gguf";
        alias = "unsloth/DeepSeek-R1-Distill-Llama-70B";
        c = "65536";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        context-shift = true;
        fit = "on";
        seed = "3407";
        temp = "1.0";
        top-p = "0.95";
        min-p = "0.01";
        top-k = "40";
        jinja = "on";
      };
      "unsloth/gemma-4-31B-it-GGUF:Q4_K_M" = {
        hf-repo = "unsloth/gemma-4-31B-it-GGUF";
        hf-file = "gemma-4-31B-it-Q4_K_M.gguf";
        alias = "unsloth/gemma-4-31B-it-UD-Q4_K_XL";
        c = "131072";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        context-shift = true;
        fit = "on";
        seed = "3407";
        temp = "1.0";
        top-p = "0.95";
        min-p = "0.01";
        top-k = "40";
        jinja = "on";
      };
      "unsloth/gemma-4-31B-it-GGUF:Q4_K_XL" = {
        hf-repo = "unsloth/gemma-4-31B-it-GGUF";
        hf-file = "gemma-4-31B-it-UD-Q4_K_XL.gguf";
        alias = "unsloth/gemma-4-31B-it-Q4-XL";
        c = "131072";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        context-shift = true;
        fit = "on";
        seed = "3407";
        temp = "1.0";
        top-p = "0.95";
        min-p = "0.01";
        top-k = "40";
        jinja = "on";
      };
      "unsloth/gemma-4-31B-it-GGUF:Q8_K_XL" = {
        hf-repo = "unsloth/gemma-4-31B-it-GGUF";
        hf-file = "gemma-4-31B-it-UD-Q8_K_XL.gguf";
        alias = "unsloth/gemma-4-31B-it-Q8-XL";
        c = "131072";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        context-shift = true;
        fit = "on";
        seed = "3407";
        temp = "1.0";
        top-p = "0.95";
        min-p = "0.01";
        top-k = "40";
        jinja = "on";
      };
      "unsloth/embeddinggemma-300m-GGUF:Q8_0" = {
        hf-repo = "unsloth/embeddinggemma-300m-GGUF";
        hf-file = "embeddinggemma-300M-Q8_0.gguf";
        alias = "unsloth/embeddinggemma-300m-Q8-0";
        c = "2048";
        fit = "on";
        seed = "3407";
        temp = "1.0";
        top-p = "0.95";
        min-p = "0.01";
        top-k = "40";
        jinja = "on";
      };
      "unsloth/gemma-4-E2B-it-GGUF:IQ2_M" = {
        hf-repo = "unsloth/gemma-4-E2B-it-GGUF";
        hf-file = "gemma-4-E2B-it-UD-IQ2_M.gguf";
        alias = "unsloth/gemma-4-E2B-it-IQ2-M";
        c = "2048";
        fit = "on";
        seed = "3407";
        temp = "1.0";
        top-p = "0.95";
        min-p = "0.01";
        top-k = "40";
        jinja = "on";
      };
      "unsloth/gemma-4-26B-A4B-it-GGUF:Q8_K_XL" = {
        hf-repo = "unsloth/gemma-4-26B-A4B-it-GGUF";
        hf-file = "gemma-4-26B-A4B-it-UD-Q8_K_XL.gguf";
        alias = "unsloth/gemma-4-26B-it-UD-Q8-K-XL";
        c = "131072";
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        context-shift = true;
        fit = "on";
        seed = "3407";
        temp = "1.0";
        top-p = "0.95";
        min-p = "0.01";
        top-k = "40";
        jinja = "on";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    vulkan-tools
    rocmPackages.rocminfo
    rocmPackages.clr
    rocmPackages.rocm-smi
    radeontop.out
  ];
}
