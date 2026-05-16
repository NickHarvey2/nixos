# AGENTS.md

## Repository Overview
This is a NixOS configuration repository managed using **Nix Flakes**. It manages three distinct hosts and uses **home-manager** for user configuration.

## Hosts
To apply changes, use `nixos-rebuild switch --flake .#<hostname>`.
- `nixos`: Standard host.
- `nixos2`: Includes `unbound.nix`, `sshd.nix`, and `llama-cpp.nix`.
- `nixos3`: Includes `nvidia.nix`.

## User Configuration
User `nick`'s configuration is managed via `home-manager` (integrated as a NixOS module).
- **Modules**: Most user-specific settings are in the `nick/` directory.
- **Environment**: `FLAKE_DIR` is set to `/home/nick/nixos`.

## Key Tools & Services
- **Opencode**: Configured via `nick/opencode-module.nix`. It uses a jailed version and connects to a local `llama.cpp` provider at `http://127.0.0.1:8080/v1`.
- **Model Management**: Use `model-picker.sh` to interact with the local model server API (`http://127.0.0.1:8080`).
- **Secrets**: Managed using `sops-nix` (see `.sops.yaml`).

## Development Workflow
1. **Modify configuration**: Edit `.nix` files in the root or `nick/`.
2. **Verify/Apply**:
   - Run `nixos-rebuild switch --flake .#<hostname>` to apply changes to a specific host.
   - From any directory, use `sudo nixos-rebuild switch --flake $FLAKE_DIR`.
   - If in `$FLAKE_DIR`, use `sudo nixos-rebuild switch --flake .`.
   - **Note**: Untracked files are not respected by Nix flakes.
   - **Note**: In rare cases, use `boot` instead of `switch` to build the generation without applying it immediately (requires reboot).
   - **Note**: Since `home-manager` is a NixOS module, `nixos-rebuild` applies both system and user changes.

## Agent Constraints
- **NEVER** attempt to execute commands to apply configuration changes (e.g., `nixos-rebuild switch`). These require `sudo` and user interaction for password elevation.
- **PERMITTED**: You may run `nixos-rebuild build --flake .#<hostname>` to validate the configuration. This builds the derivation and leaves a `result` symlink in the current directory without making system changes or requiring root privileges.
