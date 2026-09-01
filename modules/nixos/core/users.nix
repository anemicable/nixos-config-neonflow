{ config, pkgs, ... }:
let
  username = config.systemVars.username;
  avatar = ../../../assets/users/${username}.jpg;   # путь относительно конфига
in
{
  # ─────────────────────────────────────────────────────────────
  # User Accounts
  # ─────────────────────────────────────────────────────────────
  users = {
    mutableUsers = false;

    # Zsh по умолчанию для всех пользователей
    defaultUserShell = pkgs.zsh;

    users = {
      # Отключаем root
      root.hashedPassword = "!";

      # Динамическое имя пользователя
      ${config.systemVars.username} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
          "media"
          "input"
          "video"
          "audio"
          "docker"
          "qbittorrent"
          "greeter"
        ];
        hashedPasswordFile = config.sops.secrets."${config.systemVars.username}_password".path;
      };
    };
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
    execWheelOnly = true;
  };

  # 1. AccountsService (это работает надёжно)
  systemd.tmpfiles.settings.accountsservice = {
  "/var/lib/AccountsService/users/${username}" = {
    f = {
      mode = "0644";
      user = "root";
      group = "root";
      argument = ''
        [User]
        Icon=/var/lib/AccountsService/icons/${username}
        SystemAccount=false
      '';
    };
  };

  "/var/lib/AccountsService/icons/${username}" = {
    L.argument = toString avatar;
  };
};

 home-manager.users.${username} = { pkgs, ... }: {
    home.file.".face".source = avatar;
    home.file.".face.icon".source = avatar;
  };
}