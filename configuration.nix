{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

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
  boot.initrd.kernelModules = ["vfio_pci" "vfio" "vfio_iommu_type1" "vfio_virqfd" "amdgpu"];
  boot.kernelParams = ["amd_iommu=on" "vfio-pci.ids=10de:13c2,10de:0fbb"];
  boot.supportedFilesystems = ["ntfs"];

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0600 leah libvirtd -"
    "L+  /opt/rocm/clr  -  -  -  -  ${pkgs.rocmPackages.clr}"
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = false;
    allowedUDPPorts = [4010 25565];
    allowedTCPPorts = [25565];
  };

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
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.zsh.enable = true;
  programs.dconf.enable = true;
  programs.ssh.startAgent = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [libnghttp2];
  programs.virt-manager.enable = true;
  environment.shells = with pkgs; [zsh];
  nixpkgs.config.packageOverrides = pkgs : {
    renoise = pkgs.renoise.override { releasePath = /opt/renoise/bundle.tar.gz; };
  };

  environment.systemPackages = let
    # unstable = import <nixos-unstable> {config = {allowUnfree = true;};};
    development = with pkgs; [
      odin
      ols
      zig
      zls
      gcc
      alejandra
      clang-tools
      nil
      tree-sitter
      vscode-langservers-extracted
      marksman
      black
      rustup
      jdk17
      emacs-gtk
      highlight
      (python311.withPackages (ps: [
        ps.matplotlib
        ps.torch-bin
        ps.opencv4
        ps.python-lsp-server
        ps.rope
        ps.scikit-learn
        ps.pyflakes
        ps.pyglet
        ps.pyaudio
        ps.bokeh
        ps.pandas
        ps.scipy
        ps.click
        ps.seaborn
      ]))
      raylib
      unstable.helix
      cmake
    ];
    audio = with pkgs; [
      unstable.reaper
      renoise
      audacity
      pavucontrol
      qpwgraph
      vcv-rack
      libnghttp2
      nghttp2
      unstable.surge-XT
      unstable.helm
      unstable.yabridge
      unstable.zam-plugins
      unstable.oxefmsynth
      unstable.vital
      unstable.distrho
      unstable.dexed
      unstable.wolf-shaper
      unstable.bchoppr
      unstable.bshapr
      unstable.bslizr
      unstable.calf
      unstable.lsp-plugins
      unstable.airwindows-lv2
      unstable.dragonfly-reverb
      unstable.x42-plugins
      unstable.ChowKick
      unstable.ChowPhaser
      unstable.ChowCentaur
      unstable.CHOWTapeModel
      unstable.geonkick
      unstable.odin2
    ];
    media = with pkgs; [
      mpv
      ffmpeg
      feh
      zathura
    ];
    graphicalSoftware = with pkgs; [
      transmission_4-gtk
      inkscape
      discord
      bottles
      spotify
      xournalpp
      firefox
      pcmanfm
      gthumb
      libreoffice-fresh
      xarchiver
      prusa-slicer
      chromium
      prismlauncher
      flameshot
      ffmpegthumbnailer
    ];
    tools = with pkgs; [
      git
      unstable.jujutsu
      pandoc
      unzip
      ripgrep
      htop
      wget
      fzf
      unrar
      arandr
      graphite2
      usbutils
      kitty
      kitty-themes
      xorg.xkill
      xclip
      virt-manager
      looking-glass-client
      scream
      oh-my-zsh
      ranger
      atool
      tmux
      zsh
      stow
    ];
  in
    tools ++ audio ++ development ++ media ++ graphicalSoftware;

  users.users.leah = {
    isNormalUser = true;
    description = "Leah";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "lp" "scanner" "dialout"];
    shell = pkgs.zsh;
  };
  fileSystems."/mnt/files" = {
    device = "/dev/disk/by-uuid/2B9091AE40C030FA";
    fsType = "ntfs";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    google-fonts
    gyre-fonts
  ];

  services.gvfs.enable = true;
  services.printing.enable = true;
  services.blueman.enable = true;
  services.udev.enable = true;
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374b", ACTION=="add", GROUP="dialout", MODE="0664"
  '';
  services.xserver = {
    videoDrivers = ["amdgpu"];
    enable = true;
    displayManager = {defaultSession = "none+i3";};
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-rounded;
      extraPackages = with pkgs; [dmenu i3status i3lock i3blocks];
    };
    wacom.enable = true;
    layout = "us";
    xkbVariant = "";
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
      shadow-opacity  = 0.5;
      fading = true;
      backend = "glx";
      active-opacity = 1;
      inactive-opacity = 0.75;
      blur-method = "dual_kawase";
      blur-strength = 3;
      # corner-radius = 10;
      rounded-corners-exclude = ["class_g = 'i3bar'"];
    };
    opacityRules = [
      "100:class_g = 'firefox'"
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  environment.variables = let
    makePluginPath = format:
      (pkgs.lib.strings.makeSearchPath format [
        "$HOME/.nix-profile/lib"
        "/run/current-system/sw/lib"
        "/etc/profiles/per-user/$USER/lib"
      ])
      + ":$HOME/.${format}";
  in {
    DSSI_PATH   = makePluginPath "dssi";
    LADSPA_PATH = makePluginPath "ladspa";
    LV2_PATH    = makePluginPath "lv2";
    LXVST_PATH  = makePluginPath "lxvst";
    VST_PATH    = makePluginPath "vst";
    VST3_PATH   = makePluginPath "vst3";
    RANGER_LOAD_DEFAULT_RC = "false";
    EDITOR = "hx";
  };
  

  systemd.services.libvirtd.preStart = let
    qemuHook = pkgs.writeScript "qemu-hook" ''
      #!${pkgs.stdenv.shell}
      if [ "$1" = "Windows" ]; then

         	# Update the following variables to fit your setup
         	GUEST_IP="192.168.122.15"
         	GUEST_PORT="7777"
         	HOST_PORT="7777"

         	if [ "$2" = "stopped" ] || [ "$2" = "reconnect" ]; then
      		${pkgs.iptables}/bin/iptables -D FORWARD -o virbr0 -d  $GUEST_IP -j ACCEPT
      		${pkgs.iptables}/bin/iptables -t nat -D PREROUTING -p tcp --dport $HOST_PORT -j DNAT --to $GUEST_IP:$GUEST_PORT
         	fi
         	if [ "$2" = "start" ] || [ "$2" = "reconnect" ]; then
      		${pkgs.iptables}/bin/iptables -I FORWARD -o virbr0 -d  $GUEST_IP -j ACCEPT
      		${pkgs.iptables}/bin/iptables -t nat -I PREROUTING -p tcp --dport $HOST_PORT -j DNAT --to $GUEST_IP:$GUEST_PORT
         	fi
      fi
    '';
  in ''
    mkdir -p /var/lib/libvirt/hooks
    chmod 755 /var/lib/libvirt/hooks

    # Copy hook files
    ln -sf ${qemuHook} /var/lib/libvirt/hooks/qemu
  '';
  # DO NOT CHANGE THIS VERSION
  system.stateVersion = "22.05";
}
