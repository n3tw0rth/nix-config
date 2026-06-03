{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      g = "git";
      ll = "ls -al";
      vi = "nvim";
      lg = "lazygit";
      sss = "systemctl suspend";
    };

    bashrcExtra = ''
      set -o vi

      export EDITOR=nvim

      exip() {
        export IP="$1"
      }
    '';
  };

  home.packages = [
    (pkgs.writeShellScriptBin "run.pwn-web" ''
      swaymsg 'workspace 3; exec caido-desktop'
    '')

    (pkgs.writeShellScriptBin "run.dev" ''
      swaymsg 'workspace 3; exec postman'
    '')
  ];
}
