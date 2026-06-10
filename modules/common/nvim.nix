{ nix4nvchad, pkgs, ... }:
{
  imports = [ nix4nvchad.homeManagerModules.default ];

  programs.nvchad = {
    enable = true;
    backup = false;

    extraConfig = (import ./nvim/options.nix) { inherit pkgs; };
    extraPlugins = import ./nvim/plugins.nix;
    chadrcConfig = import ./nvim/chadrc.nix;
  };
}
