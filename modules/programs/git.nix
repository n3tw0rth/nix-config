{ ... }:

{
  programs.git = {
    enable = true;
    userName = "n3tw0rth";
    userEmail = "40062006+n3tw0rth@users.noreply.github.com";

    aliases = {
      a = "add";
      st = "status";
      co = "checkout";
      cm = "commit";
      br = "branch";
      pu = "push";
    };
  };

}
