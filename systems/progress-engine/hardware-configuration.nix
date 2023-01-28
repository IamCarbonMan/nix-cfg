{config, lib, pkgs, ...}: {
    imports = [<nixpkgs/nixos/modules/installer/scan/not-detected.nix>];
}