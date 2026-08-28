{ pkgs, config, ... }:
let
  vaultCipher = "${config.home.homeDirectory}/.vault-cipher";
  vaultMount  = "${config.home.homeDirectory}/.Vault";
  heliumDir   = "${vaultMount}/vivaldi";

  zenity    = "${pkgs.zenity}/bin/zenity";
  gocryptfs = "${pkgs.gocryptfs}/bin/gocryptfs";
  notify    = "${pkgs.libnotify}/bin/notify-send";
in
{

}