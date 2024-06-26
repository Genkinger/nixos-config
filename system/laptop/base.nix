{ config, pkgs, ... }:
{

  boot.kernelPackages = pkgs.linuxPackages_latest;
  powerManagement.enable = true;

  networking.hostName = "laptop";
  users.users.leah = {
    isNormalUser = true;
    description = "Leah Genkinger";
    extraGroups = [ "networkmanager" "wheel" "dialout" "audio" "video" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
