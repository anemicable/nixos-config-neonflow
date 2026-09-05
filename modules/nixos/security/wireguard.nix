{ config, ... }: {

  # Use wg-quick with the decrypted file
  
  sops.templates."wg-budapest.conf" = {
    content = ''
      [Interface]
      PrivateKey = ${config.sops.placeholder."wireguard/provider/private-key"}
      Address = 10.20.52.66/32
      DNS = 10.20.128.1

      [Peer]
      PublicKey = 5F8e35gZQLsxmdwRKZWDDSwS8yE6J16OPWtgOnHN1UI=
      AllowedIPs = 0.0.0.0/0
      Endpoint = ru-wrgrd.internetrkn.ru:60217
      PersistentKeepalive = 15
    '';
    mode = "0400";
    path = "/etc/wireguard/budapest.conf";
  };

  sops.templates."wg-yerevan.conf" = {
    content = ''
      [Interface]
      PrivateKey = ${config.sops.placeholder."wireguard/provider/private-key"}
      Address = 10.20.52.66/32
      DNS = 10.20.128.1

      [Peer]
      PublicKey = 5F8e35gZQLsxmdwRKZWDDSwS8yE6J16OPWtgOnHN1UI=
      AllowedIPs = 0.0.0.0/0
      Endpoint = ru-wrgrd.internetrkn.ru:60474
      PersistentKeepalive = 15
    '';
    mode = "0400";
    path = "/etc/wireguard/yerevan.conf";
  };

  sops.templates."wg-zagreb.conf" = {
    content = ''
      [Interface]
      PrivateKey = ${config.sops.placeholder."wireguard/provider/private-key"}
      Address = 10.20.52.66/32
      DNS = 10.20.128.1

      [Peer]
      PublicKey = 5F8e35gZQLsxmdwRKZWDDSwS8yE6J16OPWtgOnHN1UI=
      AllowedIPs = 0.0.0.0/0
      Endpoint = ru-wrgrd.internetrkn.ru:60541
      PersistentKeepalive = 15
    '';
    mode = "0400";
    path = "/etc/wireguard/zagreb.conf";
  };

  sops.templates."wg-dusseldorf.conf" = {
    content = ''
      [Interface]
      PrivateKey = ${config.sops.placeholder."wireguard/provider/private-key"}
      Address = 10.20.52.66/32
      DNS = 10.20.128.1

      [Peer]
      PublicKey = 5F8e35gZQLsxmdwRKZWDDSwS8yE6J16OPWtgOnHN1UI=
      AllowedIPs = 0.0.0.0/0
      Endpoint = ru-wrgrd.internetrkn.ru:60190
      PersistentKeepalive = 15
    '';
    mode = "0400";
    path = "/etc/wireguard/dusseldorf.conf";
  };
  
  networking.wg-quick.interfaces = {
    budapest = {
      configFile = config.sops.templates."wg-budapest.conf".path;
      autostart = true;        # ← по умолчанию поднимается этот
    };
    yerevan = {
      configFile = config.sops.templates."wg-yerevan.conf".path;
      autostart = false;
    };
    zagreb = {
      configFile = config.sops.templates."wg-zagreb.conf".path;
      autostart = false;
    };
    dusseldorf = {
      configFile = config.sops.templates."wg-dusseldorf.conf".path;
      autostart = false;
    };
  };

  systemd.services = {
    "wg-quick-budapest" = {
      wants = [ "sops-nix.service" ];
      after = [ "sops-nix.service" "network.target" ];
      requires = [ "sops-nix.service" ];
    };

    "wg-quick-yerevan" = {
      wants = [ "sops-nix.service" ];
      after = [ "sops-nix.service" "network.target" ];
    };

    "wg-quick-zagreb" = {
      wants = [ "sops-nix.service" ];
      after = [ "sops-nix.service" "network.target" ];
    };

    "wg-quick-dusseldorf" = {
      wants = [ "sops-nix.service" ];
      after = [ "sops-nix.service" "network.target" ];
    };
 }; 
  # Common fix for WireGuard clients (prevents return traffic being dropped)
  networking.firewall.checkReversePath = "loose";

  # Optional: install the tools
}