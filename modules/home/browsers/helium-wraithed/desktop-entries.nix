{ pkgs, config, osConfig, ... }:

let
  username = osConfig.systemVars.username; 
  cipherDir = "/home/${username}/.wraith-vault-cipher";
  plainDir = "/home/${username}/.wraith-vault-plain";

  # Extract the script entirely out of the desktop entry to satisfy the validator
  heliumLaunchScript = pkgs.writeShellScriptBin "helium-wraithed-launcher" ''
    if ${pkgs.util-linux}/bin/mountpoint -q "${plainDir}"; then
      helium --user-data-dir="${plainDir}/Personal" "$@"
    else
      PASSWORD=$(${pkgs.zenity}/bin/zenity --password --title="Unlock Wraith Vault" --text="Enter your master passphrase:")
      if [ -n "$PASSWORD" ]; then
        # FIX: Changed 'echo' to 'printf %s' to strip out trailing newline characters
        printf %s "$PASSWORD" | ${pkgs.gocryptfs}/bin/gocryptfs -extpass "${pkgs.coreutils}/bin/cat" "${cipherDir}" "${plainDir}" 2>/dev/null
        
        if ${pkgs.util-linux}/bin/mountpoint -q "${plainDir}"; then
          systemctl --user start gocryptfs-wraith.service
          helium --user-data-dir="${plainDir}/Personal" "$@"
        else
          ${pkgs.zenity}/bin/zenity --error --title="Access Denied" --text="Incorrect vault password. History remains encrypted."
        fi
      else
        ${pkgs.libnotify}/bin/notify-send "Unlock Cancelled" "Vault remained locked."
      fi
    fi
  '';
in
{
  # Add both utilities and our custom launcher package to user environment
  home.packages = [ 
    pkgs.libnotify 
    pkgs.zenity 
    heliumLaunchScript
  ];

  # ====================== Desktop entry ======================
  xdg.desktopEntries.helium-wraithed-personal = {
    name = "Helium Wraithed (Personal)";
    comment = "Main, personal profile of Helium Wraithed";
    
    # Points cleanly to the binary inside our custom package
    exec = "${heliumLaunchScript}/bin/helium-wraithed-launcher %U";

    icon = "/persist/home/mistflow/nixos-config/assets/icons/helium-cryonic.jpg";
    terminal = false;
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
  };
}