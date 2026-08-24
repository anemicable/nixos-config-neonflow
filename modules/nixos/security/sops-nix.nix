{ ... }:

{
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml"

    age = {
      keyFile = "/persist/home/mistflow/.config/sops/age/keys.txt";
      #sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
      generateKey = false;
    };

    secrets = {
      "mistflow-password" = {
        neededForUsers = true;
      };
    };
  };
}
