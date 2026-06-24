build-pwn:
  nixos-rebuild switch --flake "/etc/nixos#$(hostname)" --impure

