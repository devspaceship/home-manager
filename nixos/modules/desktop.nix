{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code
  ];

  services.hypridle.enable = true;

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session.command = "uwsm start hyprland-uwsm.desktop";
      initial_session = {
        command = "uwsm start hyprland-uwsm.desktop";
        user = "devspaceship";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    blueman
    dunst
    grim
    hyprlauncher
    hyprlock
    hyprpaper
    hyprshutdown
    hyprsysteminfo
    inotify-tools
    nwg-look
    playerctl
    polkit_gnome
    rofi
    slurp
    waybar
    wev
    wl-clipboard
    xdg-desktop-portal-hyprland
  ];

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
