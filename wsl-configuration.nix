# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users = {
    users.nick = {
      isNormalUser = true;
      uid = 1000;
      home = "/home/nick";
      extraGroups = ["wheel" "networkmanager"];
      shell = pkgs.zsh;
      initialHashedPassword = "$6$wQ46d7WSko7cf.k8$FKnvwh3wfVzlQEFfa/dAFQEztLHYcE6WhwnDH6IDgiOVwEA4MGDEN5.1SyeUZ3xsitQajbgBbRApHT6uAs6FI0";
    };
  };
  security.sudo.wheelNeedsPassword = true;
  programs = {
    zsh.enable = true;
  };

  virtualisation = {
    containers.enable = true; # Enable common container config files in /etc/containers
    podman = {
      enable = true;
      dockerCompat = true; # Create a `docker` alias for podman, to use it as a drop-in replacement
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };

  environment.systemPackages = with pkgs; [
    acpi
    libgcc
    gnumake
    krb5
    usbutils
  ];

  services = {
    xserver.enable = true;
    udev = {
      enable = true;
      packages = [pkgs.yubikey-personalization];
      # extra rules are needed on WSL to make the yubikey accessible
      extraRules = ''
        SUBSYSTEM=="usb", ATTR{idVendor}=="1050", ATTR{idProduct}=="0010|0110|0111|0114|0116|0401|0403|0405|0407|0410", MODE="0666"
      '';
    };
    pcscd = {
      enable = true;
      extraArgs = ["--disable-polkit"]; # No point in polkit since I'm the only user of these systems
    };
  };

  environment = {
    etc."krb5.conf".text = builtins.readFile ./krb5.conf;
    variables = {
      KRB5_CONFIG = "/etc/krb5.conf";
    };
  };

  time.timeZone = "America/Chicago";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}
