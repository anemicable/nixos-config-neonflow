{ ... }:

{
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      keyFile = "/persist/home/mistflow/.config/sops/age/keys.txt";
      #sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
      generateKey = false;
    };

    secrets = {
      "mistflow_password" = {
        neededForUsers = true;
      };
      
      "personal-email" = {};
      "professional-email" = {};
      "personal-github-name" = {};
      "professional-github-name" = {};

      "wireguard/provider/private-key" = {
        owner = "root";
        group = "root";
        mode = "0400";
      };
    };
  };
}
