{ pkgs, config, lib, ... }:
let
  username = config.systemVars.username;
in
{
  # Пользователь и группы (без изменений)
  users.users.qbittorrent = {
    isSystemUser = true;
    group = "qbittorrent";
    extraGroups = [ "media" ];
  };
  users.users.${username}.extraGroups = [ "qbittorrent" ];

  services.qbittorrent = {
    enable = true;
    user = "qbittorrent";
    group = "qbittorrent";
    webuiPort = 8080;
    openFirewall = true;

    serverConfig = {
      LegalNotice.Accepted = true;

      Preferences = {
        WebUI = {
          Username = "mistflow";
          LocalHostAuth = false;
        };

        Downloads = {
          SavePath = "/srv/torrents";           # ← основная папка для скачанных файлов

          # ← Вот и вся магия: watched folder
          ScanDirV2 = ''{"/home/mistflow/Downloads/Torrents/Incoming": 1}'';
          # 1 = использовать Default save path (/srv/torrents)
          # 0 = скачивать прямо в папку Incoming (не рекомендуется)
          DeleteTorrentFilesOnCompletion = true;   # ← добавь эту строку
        };
      };
    };
  };

  # Создаём папки declaratively
  systemd.tmpfiles.rules = [
    # Основная папка для торрентов (безопасно, вне /home)
    "d /srv/torrents 2770 qbittorrent qbittorrent -"

    # Папка Downloads у тебя (если ещё нет)
    "d /home/mistflow/Downloads 0755 mistflow users -"

    # ← Вот и вся магия: symlink-папка внутри Downloads
    "L+ /home/mistflow/Downloads/Torrents - - - - /srv/torrents"
  ];

  # Presevation
  preservation.preserveAt."/persistent".directories = [
      "/var/lib/qbittorrent"
      "/var/lib/qBittorrent"
      
      {
          directory = "/srv/torrents";
          user = "qbittorrent";
          group = "qbittorrent";
          mode = "2770";
      }
  ];
}