{ config, pkgs, lib, ... }:

let
  username = config.systemVars.username; 
  homeDir = "/home/${username}";

  cipherDir = "${homeDir}/.wraith-vault-cipher"; 
  plainDir  = "${homeDir}/.wraith-vault-plain";  

  # Target the sops file only used during declarative first-run initialization
  passwordFile = config.sops.secrets."wraith-vault/password".path;
in {
  # 1. Register sops key strictly for the setup script
  sops.secrets."wraith-vault/password" = {
    owner = username;
    group = "users";
  };

  # 2. Add dependencies
  environment.systemPackages = with pkgs; [
    gocryptfs
    fuse3
    zenity
  ];

  # 3. One-Shot Declarative Init Layer
  systemd.user.services.init-wraith-vault = {
    description = "Declaratively check and initialize Wraith Vault via sops-age";
    after = [ "sops-nix.service" ];
    wantedBy = [ "default.target" ];

    path = with pkgs; [ gocryptfs coreutils ];

    script = ''
      mkdir -p "${cipherDir}"
      mkdir -p "${plainDir}"

      if [ ! -f "${cipherDir}/gocryptfs.conf" ]; then
        echo "No vault configuration found. Initializing declaratively..."
        gocryptfs -init -extpass "cat ${passwordFile}" "${cipherDir}"
        echo "Vault initialized successfully!"
      else
        echo "Vault already exists. Skipping declarative setup."
      fi
    '';

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = false; # Service fires, ensures setup is valid, and stops cleanly
    };
  };

  # 4. Dummy tracker service to let your Desktop entry clean up cleanly on logout
  systemd.user.services.gocryptfs-wraith = {
    description = "Tracking Service for manual FUSE session lifecycle";
    after = [ "init-wraith-vault.service" ];
    
    script = "${pkgs.coreutils}/bin/sleep infinity";
    postStop = "${pkgs.fuse3}/bin/fusermount3 -u '${plainDir}' 2>/dev/null || true";

    serviceConfig = {
      Type = "simple";
      RemainAfterExit = true;
    };
  };

  environment.shellAliases = {
    vault-close = "systemctl --user stop gocryptfs-wraith.service";
  };
}