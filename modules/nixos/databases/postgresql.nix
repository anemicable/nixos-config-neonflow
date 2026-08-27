{ pkgs, lib, config, ...} :
let 
  isEnabled = lib.elem "postgresql" config.systemVars.enabledDatabases;
in
{
  services.postgresql = {
    enable = isEnabled;
    package = pkgs.postgresql_16;  # or _17, _15 — whatever you prefer

    ensureDatabases = [ "postgres" ];  # optional, the "postgres" DB usually exists by default

    # The "postgres" superuser is created automatically by the module.
    # No need to list it in ensureUsers unless you want to set extra options.

    # Make local connections (via Unix socket) passwordless for everyone
    # This is the most common and convenient setting for dev machines
    authentication = pkgs.lib.mkOverride 10 ''
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            trust
      host    all             all             ::1/128                 trust
    '';
 };
  
  # Don't start postgres with boot - only start with command
  systemd.services.postgresql.wantedBy = lib.mkForce [ ];
  # or systemd.targets.postgresql.wantedBy = lib.mkForce [ ];
}
