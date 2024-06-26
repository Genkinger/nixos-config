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
  };

    services.libinput.enable = true;
    services.libinput.touchpad.naturalScrolling = true;
}
