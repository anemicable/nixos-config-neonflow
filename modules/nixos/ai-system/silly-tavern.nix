{ ... }:
{
  services.sillytavern.enable = false;

  virtualisation.oci-containers.backend = "podman";
  virtualisation.podman.enable = true;

  virtualisation.oci-containers.containers.sillytavern = {
    image = "ghcr.io/sillytavern/sillytavern:latest";
    autoStart = true;
    extraOptions = [ "--network=host" ];
    environment = {
      SILLYTAVERN_LISTEN = "false";
      SILLYTAVERN_PORT = "8443";
      SILLYTAVERN_WHITELISTMODE = "true";
    };
    volumes = [
      "/var/lib/sillytavern/config:/home/node/app/config"
      "/var/lib/sillytavern/data:/home/node/app/data"
      "/var/lib/sillytavern/plugins:/home/node/app/plugins"
      "/var/lib/sillytavern/extensions:/home/node/app/public/scripts/extensions/third-party"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/sillytavern 0755 root root -"
    "d /var/lib/sillytavern/config 0755 root root -"
    "d /var/lib/sillytavern/data 0755 root root -"
    "d /var/lib/sillytavern/plugins 0755 root root -"
    "d /var/lib/sillytavern/extensions 0755 root root -"
  ];

  preservation.preserveAt."/persist".directories = [
    "/var/lib/sillytavern"
  ];
}