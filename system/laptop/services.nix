{...}: {
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
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
  };
}