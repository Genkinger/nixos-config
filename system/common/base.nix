{
  # config,
  pkgs,
  ...
}: {
  # imports = [./hardware-configuration.nix];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;

  hardware.bluetooth.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;
  hardware.sane.enable = true;
  hardware.opentabletdriver.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.networkmanager.enable = true;

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

  programs.zsh.enable = true;
  programs.dconf.enable = true;
  programs.ssh.startAgent = true;

  # TODO(Leah): Figure out how the fuck nix-ld works...
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    curl
    dbus
    expat
    fontconfig
    freetype
    fuse3
    gdk-pixbuf
    glib
    gtk3
    icu
    libGL
    libappindicator-gtk3
    libdrm
    libglvnd
    libnotify
    libpulseaudio
    libunwind
    libusb1
    libuuid
    libxkbcommon
    libxml2
    mesa
    nspr
    nss
    openssl
    pango
    pipewire
    stdenv.cc.cc
    systemd
    vulkan-loader
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    xorg.libxkbfile
    xorg.libxshmfence
    zlib
  ];
  environment.shells = with pkgs; [zsh];

  users.users.leah = {
    isNormalUser = true;
    description = "Leah";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "lp" "scanner" "dialout"];
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    google-fonts
    gyre-fonts
  ];

  # environment.variables = let
  #   makePluginPath = format:
  #     (pkgs.lib.strings.makeSearchPath format [
  #       "$HOME/.nix-profile/lib"
  #       "/run/current-system/sw/lib"
  #       "/etc/profiles/per-user/$USER/lib"
  #     ])
  #     + ":$HOME/.${format}";
  # in {
  #   DSSI_PATH   = makePluginPath "dssi";
  #   LADSPA_PATH = makePluginPath "ladspa";
  #   LV2_PATH    = makePluginPath "lv2";
  #   LXVST_PATH  = makePluginPath "lxvst";
  #   VST_PATH    = makePluginPath "vst";
  #   VST3_PATH   = makePluginPath "vst3";
  #   RANGER_LOAD_DEFAULT_RC = "false";
  #   EDITOR = "hx";
  # };
}
