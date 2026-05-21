{
  pkgs,
  models,
  ...
}: let
  attrsToRemoveForLlama = [ "name" ];
in {
  hardware.amdgpu.opencl.enable = true;
  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp-rocm;
    port = 8080;
    host = "127.0.0.1";
    extraFlags = ["-ngl" "999" "--flash-attn" "on"];
    # llama.cpp won't know what to do with the "name" attibute, so remove it from each model
    modelsPreset = builtins.mapAttrs (k: v: removeAttrs v attrsToRemoveForLlama) models;
  };

  environment.systemPackages = with pkgs; [
    vulkan-tools
    rocmPackages.rocminfo
    rocmPackages.clr
    rocmPackages.rocm-smi
    radeontop.out
  ];
}
