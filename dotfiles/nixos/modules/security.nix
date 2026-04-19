{ pkgs, ... }:
{
  services.udev.packages = with pkgs; [ yubikey-personalization ];

  security = {
    pam = {
      services = {
        hyprlock.u2fAuth = true;
        login.u2fAuth = true;
        polkit-1.u2fAuth = true;
        sudo.u2fAuth = true;
      };
      u2f.settings.cue = true;
    };
    polkit.enable = true;
    rtkit.enable = true;
  };

  # YubiKey access by polkit
  systemd.services."polkit-agent-helper@".serviceConfig = {
    PrivateDevices = false;
    DevicePolicy = "closed";
    DeviceAllow = [ "char-hidraw rw" ];
    ProtectHome = false;
  };
}
