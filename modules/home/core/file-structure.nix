# home.nix или home-manager.users.USERNAME
{ lib, config, ... }:
let
  # Опишите структуру один раз. Меняется редко — правите только этот список.
  homeTree = [
    "Dev"
    "Data"
    "Data/.sync"
    "Gaming"
    "Books"
    ".Vault"
    ".db-storage"
  ];
in {
  xdg.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;  # реально создать папки при активации

    # значения по умолчанию и так такие, можно не писать
    desktop     = "${config.home.homeDirectory}/Desktop";
    documents   = "${config.home.homeDirectory}/Documents";
    download    = "${config.home.homeDirectory}/Downloads";
    music       = "${config.home.homeDirectory}/Music";
    pictures    = "${config.home.homeDirectory}/Pictures";
    publicShare = "${config.home.homeDirectory}/Public";
    templates   = "${config.home.homeDirectory}/Templates";
    videos      = "${config.home.homeDirectory}/Videos";
  };

  home.file = lib.listToAttrs (map (path: {
    name = "${path}/.keep";
    value = { text = ""; };
  }) homeTree);
}