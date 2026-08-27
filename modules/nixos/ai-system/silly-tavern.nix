{ config, lib, pkgs, ... }:

let
  aiLevel = config.systemVars.aiIntegrationLevel;
in
{

  systemd.tmpfiles.rules = [
    "d /persistent/var/lib/sillytavern/config    0755 1000 1000 -"
    "d /persistent/var/lib/sillytavern/data      0755 1000 1000 -"
    "d /persistent/var/lib/sillytavern/plugins   0755 1000 1000 -"
  ];

  virtualisation.oci-containers.containers.sillytavern =
    lib.mkIf (lib.elem aiLevel [ "conversational-only" "full" ]) {
      image = "ghcr.io/sillytavern/sillytavern:release";
      autoStart = true;
      
      extraOptions = [ "--network=host" ];

      volumes = [
        "/persistent/var/lib/sillytavern/config:/home/node/app/config"
        "/persistent/var/lib/sillytavern/data:/home/node/app/data"
        "/persistent/var/lib/sillytavern/plugins:/home/node/app/plugins"
      ];

      environment = {
        PUID = "1000";               # ← UID твоего пользователя (mistflow)
        PGID = "1000";               # ← GID
        SILLYTAVERN_PORT = "8443";

        SILLYTAVERN_TZ = "Europe/Moscow";
        SILLYTAVERN_PRIVATEADDRESSWHITELIST_ENABLED = "true";
        SILLYTAVERN_WHITELIST = "[\"::1\", \"127.0.0.1\", \"10.88.0.1\"]";
      };
    };

    networking.firewall.allowedTCPPorts = [
      8443
    ];

    #sops.secrets = {
    #  "sillytavern/basic_auth_user" = {
    #    owner = "root";
    #    group = "root";
    #    mode = "0440";
    #  };

    #  "sillytavern/basic_auth_password" = {
    #    owner = "root";
    #    group = "root";
    #    mode = "0440";
    #  };
    #};
}