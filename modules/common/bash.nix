{ ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      g = "git";
      ll = "ls -al";
      vi = "nvim";
      lg = "lazygit";
    };

    bashrcExtra = ''
      set -o vi

      export EDITOR=nvim

      exip() {
        export IP="$1"
      }
    '';
  };
}
