{pkgs, ...}: {
  networking.hostName = "tower";
  networking.firewall = {
    enable = false;
    allowedUDPPorts = [4010 25565];
    allowedTCPPorts = [25565];
  };

  boot.supportedFilesystems = ["ntfs"];
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  fileSystems."/mnt/files" = {
    device = "/dev/disk/by-uuid/2B9091AE40C030FA";
    fsType = "ntfs";
  };

  users.users.leah = {
    isNormalUser = true;
    description = "Leah";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "lp" "scanner" "dialout"];
    shell = pkgs.zsh;
  };

  musnix.enable = true;

  system.stateVersion = "22.05";
}
