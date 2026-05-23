{pkgs,lib, ... }:

{
home.packages = [ pkgs.terminator ];

home.file.".config/terminator/config" = lib.mkForce {
  enable = false;
};

home.activation.terminatorConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
  mkdir -p $HOME/.config/terminator
  cp ${./terminator/terminator-config} $HOME/.config/terminator/config
  chmod 644 $HOME/.config/terminator/config
'';

}


