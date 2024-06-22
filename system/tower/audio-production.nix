{pkgs, ...}:
{
  nixpkgs.config.packageOverrides = pkgs : {
    renoise = pkgs.renoise.override { releasePath = /opt/renoise/bundle.tar.gz; };
  };

  environment.systemPackages = with pkgs; [
    renoise
    reaper
    audacity
  ];
}
