{ config, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware = {
    enableAllFirmware = true;
    nvidia = {
      nvidiaSettings = true;
      modesetting.enable = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    # nvidia-container-toolkit.enable = true;
    keyboard.zsa.enable = true;
    bluetooth.enable = true;
  };
}
