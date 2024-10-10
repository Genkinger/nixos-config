{pkgs, ...}: {

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
      # corner-radius = 10;
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
