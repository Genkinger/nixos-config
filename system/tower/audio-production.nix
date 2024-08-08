{pkgs, ...}: {
  nixpkgs.config.packageOverrides = pkgs: {
    renoise = pkgs.renoise.override {releasePath = /opt/renoise/bundle.tar.gz;};
  };

  environment.systemPackages = with pkgs; [
    renoise
    reaper
    audacity
    vital
    unstable.bitwig-studio
    distrho
    zam-plugins
    surge-XT
    lsp-plugins
    helm
    odin2
  ];
}
