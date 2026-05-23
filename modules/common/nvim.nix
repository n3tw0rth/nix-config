{ nix4nvchad, ... }:
{
  imports = [ nix4nvchad.homeManagerModules.default ];

  programs.nvchad = {
    enable = true;
    backup = false;

    extraConfig = import ./nvim/options.nix;
    extraPlugins = import ./nvim/plugins.nix;
    chadrcConfig = import ./nvim/chadrc.nix;
  };
}
