{ ... }:
{
  virtualisation = {
    containers.enable = true;
    libvirtd = {
      enable = true;
      # qemu.swtpm.enable = true; # software TPM emulation, for TPM-based LUKS testing
    };
    podman = {
      enable = true;
      dockerCompat = true;
      # Required for containers under podman compose to communicate
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  programs.virt-manager.enable = true;
}
