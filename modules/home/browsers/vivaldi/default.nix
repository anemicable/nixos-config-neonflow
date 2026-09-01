# vivaldi-cryonic/home.nix
{ pkgs, osConfig, config, inputs, ... }:
let
  # Purplemist
  vaultPathMoonflow = "${config.home.homeDirectory}/.db-storage";
  configPathMoonflow = "${config.home.homeDirectory}/.config/vivaldi-moonflow";
in
{
  imports = [ ./desktop-entries.nix ];
}