{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) lib;
  pkgsDir = ./pkgs;
  entries = if builtins.pathExists pkgsDir then builtins.readDir pkgsDir else {};
  packageNames = builtins.attrNames (lib.filterAttrs (_: type: type == "directory") entries);
in
builtins.listToAttrs (map (name: {
  inherit name;
  value = pkgs.callPackage (pkgsDir + "/${name}") {};
}) packageNames)
