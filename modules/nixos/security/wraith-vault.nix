{ config, pkgs, lib, ... }:

let
  # --- CUSTOMIZATION VARIABLES ---
  username = config.systemVars.username; # ⬅️ Replace with your actual system username
  homeDir = "/home/${username}";

  # Directory mappings for your Helium config
  cipherDir = "${homeDir}/.wraith-vault-cipher"; # 🔒 Sync THIS folder via your private cloud
  plainDir  = "${homeDir}/.wraith-vault-plain";  # 🔓 Decrypted folder where the browser reads data

  # Fetch the decrypted password path exposed by sops-nix
  passwordFile = config.sops.secrets."wraith-vault/password".path;
in {
  # 1. Register your sops secret so NixOS extracts it securely
  sops.secrets.wraith-vault.password = {
    owner = username;
    group = "users";
  };

  # 2. Automatically install gocryptfs and FUSE tools onto your system
  environment.systemPackages = with pkgs; [
    gocryptfs
    fuse3
  ];

  # 3. Integrated lifecycle script managing your vault creation and mount
  systemd.user.services.gocryptfs-wraith = {
    Unit = {
      Description = "Automated Lifecycle for Helium Browser gocryptfs Vault";
      # Ensure sops has decrypted your password before this service fires
      After = [ "sops-nix.service" ];
      WantedBy = [ "default.target" ];
    };

    Service = {
      Type = "forking";
      RemainAfterExit = true;

      # INTEGRATED FIRST-RUN CHECK & CREATION SCRIPT
      ExecStartPre = pkgs.writeShellScript "init-wraith-vault" ''
        # Ensure our target root directories exist in user space
        mkdir -p "${cipherDir}"
        mkdir -p "${plainDir}"

        # If the gocryptfs config signature is missing, format/initialize the vault
        if [ ! -f "${cipherDir}/gocryptfs.conf" ]; then
          echo "No vault signature detected. First-time setup starting..."
          
          # Initialize the vault non-interactively using the sops password file
          ${pkgs.gocryptfs}/bin/gocryptfs -init -extpass "${pkgs.coreutils}/bin/cat ${passwordFile}" "${cipherDir}"
          
          echo "Vault successfully initialized at ${cipherDir}"
        else
          echo "Existing gocryptfs vault profile detected. Skipping initialization."
        fi
      '';

      # THE MOUNT COMMAND
      # Mounts the encrypted cipher folder into the plain folder using FUSE3
      ExecStart = "${pkgs.gocryptfs}/bin/gocryptfs -extpass '${pkgs.coreutils}/bin/cat ${passwordFile}' '${cipherDir}' '${plainDir}'";
      
      # THE UNMOUNT COMMAND
      # Safely closes out the volume when you log out or shut down your machine
      ExecStop = "${pkgs.fuse3}/bin/fusermount3 -u '${plainDir}'";
    };
  };

  environment.shellAliases = {
    vault-open = "${pkgs.gocryptfs}/bin/gocryptfs -extpass '${pkgs.coreutils}/bin/cat ${passwordFile}' '${cipherDir}' '${plainDir}'";
    vault-close = "${pkgs.fuse3}/bin/fusermount3 -u '${plainDir}'";
  };
}