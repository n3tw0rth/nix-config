{ ... }:

{
  programs.git = {
    enable = true;
    userName = "n3tw0rth";
    userEmail = "40062006+n3tw0rth@users.noreply.github.com";

    # includes = [
    #   {
    #     condition = "gitdir:~/projects/";
    #     contents = {
    #       user = {
    #         name = "Work Name";
    #         email = "work@company.com";
    #       };
    #     };
    #   }
    # ];
  };

}
