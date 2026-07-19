# nixos-config

Flake-based NixOS configuration for my machines, with [home-manager](https://github.com/nix-community/home-manager) for user-level config.

## Hosts

- **pwn-potato** : this machines used for some security stuff
- **wage-potato** : this machine earns the paycheck

## Structure

```
flake.nix        # inputs and host definitions
hosts/           # per-host configuration and home-manager config
modules/
  common/        # shared config (bash, nvim, ...)
  dev/           # development tools
  langs/         # language toolchains (c, go, rust, python, nodejs)
  programs/      # apps and desktop (swaywm, kitty, firefox, tmux, ...)
  pwn/           # security tools (ghidra, wordlists, ...)
```

## Usage

Rebuild the current host:

```sh
sudo just 
```
