{pkgs, ...}: {
  hardware.amdgpu.opencl.enable = true;

  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp-rocm;
    port = 8080;
    host = "127.0.0.1";
    extraFlags = [ "-ngl" "999" ];
    modelsPreset = {
      "Qwen3-Coder-Next" = {
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
      "gpt-oss-20b" = {
        hf-repo = "unsloth/gpt-oss-20b-GGUF";
        hf-file = "gpt-oss-20b-UD-Q8_K_XL.gguf";
        alias = "unsloth/gpt-oss-20b";
        c = "65536";
        fit = "on";
        seed = "3407";
        temp = "1.0";
        top-p = "0.95";
        min-p = "0.01";
        top-k = "40";
        jinja = "on";
      };
      "Qwen3.5-35B-A3B" = {
        hf-repo = "unsloth/Qwen3.5-35B-A3B-GGUF";
        hf-file = "Qwen3.5-35B-A3B-UD-Q8_K_XL.gguf";
        alias = "unsloth/Qwen3.5-35B-A3B";
        c = "65536";
        fit = "on";
        seed = "3407";
        temp = "1.0";
        top-p = "0.95";
        min-p = "0.01";
        top-k = "40";
        jinja = "on";
      };
      "DeepSeek-R1-Distill-Llama-70B" = {
        hf-repo = "unsloth/DeepSeek-R1-Distill-Llama-70B-GGUF";
        hf-file = "DeepSeek-R1-Distill-Llama-70B-UD-Q5_K_XL.gguf";
        alias = "unsloth/DeepSeek-R1-Distill-Llama-70B";
        c = "65536";
        fit = "on";
        seed = "3407";
        temp = "1.0";
        top-p = "0.95";
        min-p = "0.01";
        top-k = "40";
        jinja = "on";
      };
      "gemma-4-31B-it-GGUF" = {
        hf-repo = "unsloth/gemma-4-31B-it-GGUF";
        hf-file = "gemma-4-31B-it-UD-Q8_K_XL.gguf";
        alias = "unsloth/gemma-4-31B-it-GGUF";
        c = "65536";
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
  ];
}
