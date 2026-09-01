{ config, lib, pkgs, ... }:

let
  aiLevel = config.systemVars.aiIntegrationLevel;
in
{
  # Директории для impermanence
  systemd.tmpfiles.rules = [
    "d /persistent/var/lib/open-webui 0755 1000 1000 -"
  ];

  virtualisation.oci-containers.containers.open-webui =
    lib.mkIf (lib.elem aiLevel [ "coding-only" "full" ]) {
      image = "ghcr.io/open-webui/open-webui:main";   # или :cuda если с GPU

      autoStart = true;

      extraOptions = [ "--network=host" ];

      volumes = [
        "/persistent/var/lib/open-webui:/app/backend/data"
      ];

      #environmentFiles = [
      #  config.sops.secrets."open-webui".path
      #];

      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = "Europe/Moscow";

        # Порт самого приложения
        PORT = "8220";                    # Open WebUI использует PORT, а не SILLYTAVERN_PORT

        # Подключение к Ollama (с network=host)
        OLLAMA_BASE_URL = "http://127.0.0.1:11434";

        # Безопасность (по аналогии)
        # WEBUI_AUTH = "true";            # включи, если хочешь логин/пароль
        # ENABLE_SIGNUP = "false";
      };
    };
  
  # Sops Auth

  #sops.secrets."open-webui" = {
  #  sopsFile = ../../../secrets/open-webui-env.yaml;
  #  format = "yaml";
  #  owner = "root";
  #  mode = "0400";

  #  key = "WEBUI_ADMIN_NAME";
  #};

  # Firewall
  networking.firewall.allowedTCPPorts = [ 8220 ];
}