{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gammastep
  ];

  services.gammastep = {
    enable = true;

    # Schedule and set time range for dusk/dawn
    duskTime = "18:35-20:15";
    dawnTime = "6:00-7:45";

    # Temperature to use at night/day (between 1000 and 25000 Kelvin).
    temperature = {
      day = 5500;
      night = 3500;
    };
  };
}
