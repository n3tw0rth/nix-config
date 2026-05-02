{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.wordlists.override {
      lists = with pkgs; [ rockyou seclists ];
    })
  ];

  home.file."wordlists".source =
    "${pkgs.wordlists.override {
      lists = with pkgs; [ rockyou seclists ];
    }}/share/wordlists";
}
