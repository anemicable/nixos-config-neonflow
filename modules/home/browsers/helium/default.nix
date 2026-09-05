{ pkgs, config, ... }:
let
  vaultCipher = "${config.home.homeDirectory}/.db-cipher";
  vaultMount  = "${config.home.homeDirectory}/.db-storage";
  heliumDir   = "${vaultMount}/helium";

  zenity    = "${pkgs.zenity}/bin/zenity";
  gocryptfs = "${pkgs.gocryptfs}/bin/gocryptfs";
  notify    = "${pkgs.libnotify}/bin/notify-send";
in
{

}