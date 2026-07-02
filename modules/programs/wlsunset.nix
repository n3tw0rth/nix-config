{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wlsunset
  ];

  services.wlsunset = {
    enable = true;

    temperature = {
      day = 3500;
      night = 3000;
    };

    sunrise = "06:00";
    sunset = "18:00";

    #gamma = 1.0;

    #For location based sunrise/sunset
    #
    #latitude = 23.5;
    #longitude = 91.7;
  };
}
