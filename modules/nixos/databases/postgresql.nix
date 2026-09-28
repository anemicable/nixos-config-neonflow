{ pkgs, lib, config, ...} :
let 
  isEnabled = lib.elem "postgresql" config.systemVars.enabledDatabases;
in
{
  services.postgresql = {
    enable = isEnabled;
    package = pkgs.postgresql_16;

    ensureDatabases = [ "mistflow" ];
    ensureUsers = [
      {
        name = "mistflow";
        ensureDBOwnership = true;
        ensureClauses = {
          login = true;
          createdb = true;
          # для локальной разработки можно и так:
          # superuser = true;
        };
      }
    ];

    authentication = pkgs.lib.mkOverride 10 ''
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            trust
      host    all             all             ::1/128                 trust
    '';
  };

  systemd.services.postgresql.wantedBy = lib.mkForce [ ];
}
