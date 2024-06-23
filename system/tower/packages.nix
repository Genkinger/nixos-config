{pkgs, ...}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    fzf
    virt-manager
    looking-glass-client
    scream    
    dotnet-runtime
  ];
}
