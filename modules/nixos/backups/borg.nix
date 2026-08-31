{ config, lib, ... }:
let
  hostname = config.systemVars.hostname;
  username = config.systemVars.username;
  secret = name: config.sops.secrets.${name}.path;

  repoSecret =
    if hostname == "bluebird" then "borg/bluebird/repo"
    else if hostname == "moonbox" then "borg/moonbox/repo"
    else throw "unknown hostname: ${hostname}";
in
{
  sops.secrets."borg/bluebird/repo" = { owner = "root"; mode = "0400"; };
  sops.secrets."borg/moonbox/repo"  = { owner = "root"; mode = "0400"; };
  sops.secrets."borg/passphrase" = { owner = "root"; mode = "0400"; };
  sops.secrets."borg/ssh-private-key" = { owner = "root"; mode = "0400"; };
  sops.secrets."borg/known-hosts" = { owner = "root"; mode = "0404"; };

  sops.templates."borg-known-hosts" = {
    content = ''
      ${config.sops.placeholder."borg/known-hosts"}
    '';
    owner = "root";
    mode = "0444";
  };

  sops.templates."borg.env" = {
    content = ''
      BORG_REPO=${config.sops.placeholder."${repoSecret}"}
    '';
    owner = "root";
    mode = "0400";
  };

  services.borgbackup.jobs =
    lib.mkIf (hostname == "bluebird" || hostname == "moonbox") {
      "${hostname}-system" = {
        paths = [ "/persist" ];
        exclude = [
          "**/.cache"
          "**/Cache"
          "/persist/var/lib/borg"
          "/persist/home/${username}/Books"
          "/persist/home/${username}/Gaming"
          "/persist/home/${username}/Videos"
          "/persist/home/${username}/Downloads"
        ];

        repo = "\${BORG_REPO}";

        encryption = {
          mode = "repokey-blake2";
          passCommand = "cat ${secret "borg/passphrase"}";
        };

        environment = {
          BORG_RSH = "ssh -i ${secret "borg/ssh-private-key"} -o UserKnownHostsFile=${config.sops.templates."borg-known-hosts".path} -o StrictHostKeyChecking=yes";
          BORG_CACHE_DIR = "/persist/var/lib/borg/cache";
          BORG_SECURITY_DIR = "/persist/var/lib/borg/security";
          BORG_CONFIG_DIR = "/persist/var/lib/borg/config";
        };

        compression = "auto,zstd";
        startAt = "daily";
        persistentTimer = true;
        doInit = false;

        prune.keep = {
          daily = 7;
          weekly = 4;
          monthly = 3;
        };
      };
    };

  systemd.services."borgbackup-job-${hostname}-system".serviceConfig.EnvironmentFile = [
    config.sops.templates."borg.env".path
  ];

  systemd.tmpfiles.rules = [
    "d /persist/var/lib/borg 0700 root root -"
    "d /persist/var/lib/borg/cache 0700 root root -"
    "d /persist/var/lib/borg/security 0700 root root -"
    "d /persist/var/lib/borg/config 0700 root root -"
  ];

  environment.shellAliases = {
    borg-backup = "systemctl start borgbackup-job-${hostname}-system";
    borg-backup-log = "journalctl -u borgbackup-job-${hostname}-system -f";
  };
}