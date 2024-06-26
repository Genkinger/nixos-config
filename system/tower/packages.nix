{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fzf
    virt-manager
    looking-glass-client
    scream    
    dotnet-runtime
  ];
}
