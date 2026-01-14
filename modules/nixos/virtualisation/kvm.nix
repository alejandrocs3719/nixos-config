{ lib, config, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true; # TPM emulation
      vhostUserPackages = with pkgs; [ virtiofsd ];
      ovmf.enable = true; # UEFI
    }
  };

  # Enable USB redirection
  virtualisation.spiceUSBRedirection.enable = true;
  # Enable file sharing with host
  #services.spice-webdavd.enable = true;

  programs.virt-manager.enable = true;
  users.users.alejandro.extraGroups = [ "libvirtd" ];

  #
  environment.systemPackages = with pkgs; [
    
  ];
}