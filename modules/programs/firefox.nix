{ ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "layout.css.devPixelsPerPx" = "0.9"; # 90% zoom
      };
    };
  };
}
