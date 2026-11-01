{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableAllFirmware = true;
  hardware.nvidia = {
    nvidiaSettings = true;
    modesetting.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  # hardware.nvidia-container-toolkit.enable = true;
  hardware.keyboard.zsa.enable = true;
  hardware.bluetooth.enable = true;
}
