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

      mkcd() { mkdir -p "$1" && cd "$1"; }
    '';
  };
}
