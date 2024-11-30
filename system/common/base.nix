{
  pkgs,
  config,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;

  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

  hardware.bluetooth.enable = true;
  hardware.sane.enable = true;
  hardware.opentabletdriver.enable = true;

  hardware.graphics.enable32Bit = true;
  hardware.graphics.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

  networking.networkmanager.enable = true;
  # networking.networkmanager.applet.enable = true;
  networking.networkmanager.plugins = with pkgs; [networkmanager-l2tp networkmanager_strongswan networkmanager-vpnc];

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.utf8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.utf8";
    LC_IDENTIFICATION = "de_DE.utf8";
    LC_MEASUREMENT = "de_DE.utf8";
    LC_MONETARY = "de_DE.utf8";
    LC_NAME = "de_DE.utf8";
    LC_NUMERIC = "de_DE.utf8";
    LC_PAPER = "de_DE.utf8";
    LC_TELEPHONE = "de_DE.utf8";
    LC_TIME = "de_DE.utf8";
  };

  security.rtkit.enable = true;

  environment.shells = with pkgs; [zsh];
  environment.variables.EDITOR = "hx";
  environment.variables.HOSTNAME = "${config.networking.hostName}";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    google-fonts
    gyre-fonts
  ];
}
