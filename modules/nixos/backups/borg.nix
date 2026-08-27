
{ config, ... }:
let
  hostname = config.systemVars.hostname;
  username = config.systemVars.username;
  secret = name: config.sops.secrets.${name}.path;
in
{
  # Secrets management
  sops.secrets."borg/repo" = {
    owner = "root";
    mode = "0400";
  };
  sops.secrets."borg/passphrase" = {
    owner = "root";
    mode = "0400";
  };
  sops.secrets."borg/ssh-private-key" = {
    owner = "root";
    mode = "0400";
  };

  sops.secrets."borg/known-hosts" = {
    owner = "root";
    mode = "0404";
  };

  sops.templates."borg-known-hosts" = {
    content = ''
      ${config.sops.placeholder."borg/known-hosts"}
    '';
    owner = "root";
    mode = "0444";
  };

  sops.templates."borg.env" = {
    content = ''
      BORG_REPO=${config.sops.placeholder."borg/repo"}
    '';
    owner = "root";
    mode = "0400";
  };


  # Job
  services.borgbackup.jobs."${hostname}-system" = {
    paths = [ "/persist" ];
    exclude = [
      "**/.cache"
      "**/Cache"
      "/persist/var/lib/borg"
      "/persist/home/${username}/Books"
      "/persist/home/${username}/Gaming"
      "/persist/home/${username}/Videos"
    ];

    repo = "\${BORG_REPO}";

    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat ${secret "borg/passphrase"}";
    };

    environment = {
      BORG_RSH = "ssh -i ${secret "borg/ssh-private-key"} -o UserKnownHostsFile=${config.sops.templates."borg-known-hosts".path} -o StrictHostKeyChecking=yes";
      BORG_CACHE_DIR = "/var/lib/borg/cache";
      BORG_SECURITY_DIR = "/var/lib/borg/security";
      BORG_CONFIG_DIR = "/var/lib/borg/config";
    };
    compression = "auto,zstd";
    startAt = "daily";
    persistentTimer = true;
    doInit = true;

    prune.keep = {
      daily = 7;
      weekly = 4;
      monthly = 3;
    };
  };

  systemd.services."borgbackup-job-system".serviceConfig.EnvironmentFile = [
    config.sops.templates."borg.env".path
  ];
}