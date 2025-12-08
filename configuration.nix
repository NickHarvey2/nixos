# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable networking
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # PulseAudio and PipeWire use the RealtimeKit system service (which hands out realtime scheduling priority to user processes on demand) to acquire realtime priority
  security.rtkit.enable = true;

  # List services that you want to enable:
  services = {
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
    };
    displayManager.sddm.enable = true;

    # Configure keymap in X11
    xserver.xkb = {
      variant = "";
      layout = "us";
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Support for yubikey as smartcard
    udev = {
      enable = true;
      packages = [pkgs.yubikey-personalization];
      extraRules = ''
        SUBSYSTEM=="usb", ATTR{idVendor}=="1050", ATTR{idProduct}=="0010|0110|0111|0114|0116|0401|0403|0405|0407|0410", MODE="0666"
      '';
    };
    pcscd = {
      enable = true;
      extraArgs = ["--disable-polkit"]; # No point in polkit since I'm the only user of these systems
    };

    # Enable automatic mounting of inserted media
    udisks2.enable = true;

    netbird = {
      enable = true;
      ui.enable = true;
    };

    # Enable the OpenSSH daemon.
    # openssh.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    steam.enable = true;
    zsh.enable = true;
  };

  users.users.nick = {
    isNormalUser = true;
    description = "Nick";
    home = "/home/nick";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = true;

  virtualisation = {
    containers.enable = true; # Enable common container config files in /etc/containers
    podman = {
      enable = true;
      dockerCompat = true; # Create a `docker` alias for podman, to use it as a drop-in replacement
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };

  environment.systemPackages = with pkgs; [
    usbutils
    acpi
    libgcc
    gnumake
    mako
    xdg-desktop-portal-hyprland
    waybar
    rofi
    libnotify
    hyprpaper
    hypridle
    hyprlock
    swaylock
    networkmanagerapplet
    nwg-look
    udiskie
    brightnessctl
    mpv
    pavucontrol
    kmod
    findutils
  ];

  fonts.packages = with pkgs; [
    dejavu_fonts
    nerd-fonts.jetbrains-mono
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
