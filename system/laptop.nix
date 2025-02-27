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

  hardware.graphics.enable32Bit = true;
  hardware.graphics.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = ["192.168.178.19" "192.168.178.1"];

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
    noto-fonts-cjk-sans
    noto-fonts-emoji
    google-fonts
    gyre-fonts
    iosevka
    mononoki
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  powerManagement.enable = true;

  networking.hostName = "laptop";
  users.users.leah = {
    isNormalUser = true;
    description = "Leah Genkinger";
    extraGroups = [ "networkmanager" "wheel" "dialout" "audio" "video" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "24.05"; # Did you read the comment?

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

    services.auto-cpufreq.enable = true;
    services.auto-cpufreq.settings = {
      battery = {
         governor = "powersave";
         turbo = "never";
      };
      charger = {
         governor = "performance";
         turbo = "auto";
      };
    };

  services.xserver = {
    dpi = 140;
  };

    services.libinput.enable = true;
    services.libinput.touchpad.naturalScrolling = true;


  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    prismlauncher
    kicad
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    # docker-compose # start group of containers for dev
    podman-compose # start group of containers for dev
    dunst
    libnotify
    git
    lazygit
    stow
    unstable.helix
    kitty
    just
    firefox
    pcmanfm
    unzip
    ripgrep
    htop
    fzf
    wget
    unrar
    arandr
    xorg.xkill
    xclip
    oh-my-zsh
    atool
    ranger
    zsh
    mpv
    ffmpeg
    vlc
    gthumb
    feh
    zathura
    discord
    flameshot
    pavucontrol
    bc
    helvum
    qpwgraph
    coppwr
    spaceFM
    libresprite
    tmux
  ];

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" ];
    theme = "cypher";
  };
  programs.dconf.enable = true;
  programs.ssh.startAgent = true;
  programs.direnv.enable = true;
  programs.nm-applet.enable = true;

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

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";
  xdg.portal.enable = true;
  services.flatpak.enable = true;
  services.gvfs.enable = true;
  services.printing.enable = true;
  services.blueman.enable = true;
  services.devmon.enable = true;
  services.udisks2.enable = true;
  services.udev.enable = true;
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374b", ACTION=="add", GROUP="dialout", MODE="0664"
  '';

  services.systembus-notify.enable = true;
  services.displayManager = {
    defaultSession = "none+i3";
  };

  services.xserver = {
    videoDrivers = ["amdgpu"];
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-rounded;
      extraPackages = with pkgs; [ dmenu i3status i3lock i3blocks rofi ];
    };
    wacom.enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.picom = {
    enable = true;
    settings = {
      shadow = true;
      full-shadow = true;
      shadow-opacity = 0.5;
      fading = true;
      backend = "glx";
      active-opacity = 1;
      inactive-opacity = 0.75;
      blur-method = "dual_kawase";
      blur-strength = 3;
      rounded-corners-exclude = ["class_g = 'i3bar'"];
    };
    opacityRules = [
      "100:class_g = 'firefox'"
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
