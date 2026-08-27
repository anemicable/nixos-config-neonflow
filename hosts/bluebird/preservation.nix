{
  preservation = {
    enable = true;

    preserveAt."/persist" = {
      directories = [
        "/etc/nixos"
        "/etc/ssh"
        "/etc/NetworkManager/system-connections"
        "/var/lib/systemd"
        "/var/lib/sops-nix"
        "/var/lib/AccountsService"
        "/var/lib/bluetooth"
        "/var/lib/containers"
        "/var/lib/borg"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
      ];

      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];

      # Preserve user files
      users.mistflow = {
         directories = [
            "Data"
            "Dev"
            "Documents"
            "Downloads"
            "Pictures"
            "Videos"
            "Music"
            "Gaming"
            "Books"
            
            ".config"
            ".local/share"
            ".local/share/icons"
            ".local/share/DankMaterialShell"
            ".java"
            ".junie"
            ".vscode"
            ".vscode-shared"
            ".vscode-oss"
            ".vscode-oss-shared"
            ".ssh"
            ".mozilla"
            ".vault-cipher"
            
            "nixos-config"
         ];
      
         files = [
      
         ];
       };
    };
  };

  systemd.suppressedSystemUnits = [
    "systemd-machine-id-commit.service"
  ];
}
