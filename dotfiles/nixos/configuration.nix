{ config, pkgs, ... }: {
  imports = [ /etc/nixos/hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableAllFirmware = true;
  hardware.nvidia = {
    nvidiaSettings = true;
    modesetting.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.nvidia-container-toolkit.enable = true;
  hardware.keyboard.zsa.enable = true;
  hardware.bluetooth.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.nix-ld.enable = true;
  # wayvnc.enable = true;
  programs.zsh.enable = true;

  programs.seahorse.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "devspaceship" ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true; # enables *.local resolution over IPv4 via NSS
    nssmdns6 = true; # IPv6
    openFirewall = true; # opens UDP 5353 in the firewall
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  services.displayManager.gdm = {
    banner = "@devspaceship";
    enable = true;
    wayland = true;
  };

  services.gnome.gnome-keyring.enable = true;
  services.hypridle.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  networking = {
    hostName = "home";
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        # 22
        # 5900
      ];
      logRefusedPackets = true;
    };
  };

  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  security = {
    pam = {
      services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
        polkit-1.u2fAuth = true;
      };
      u2f.settings.cue = true;
    };
    polkit.enable = true;
    rtkit.enable = true;
  };

  users.users.devspaceship = {
    isNormalUser = true;
    description = "Thomas Saint-Gérand";
    extraGroups = [ "input" "networkmanager" "podman" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyG0chfBt6coIm3D6DlvvsaBer7Gan/65PgUlPdmu/f"
    ];
  };
  users.defaultUserShell = pkgs.zsh;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    blueberry
    dunst
    hyprlauncher
    hyprlock
    hyprpaper
    # hyprshutdown
    hyprsysteminfo
    inotify-tools
    nwg-look
    rofi
    waybar
    wev
    xdg-desktop-portal-hyprland
  ];

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      # Required for containers under podman compose to communicate
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
