{ pkgs, ... }:
{
  sops.secrets."db-storage/password" = { };
  
  environment.shellAliases = {
    vault-open = "mkdir -p ~/.Vault && gocryptfs ~/.vault-cipher ~/.Vault";
    vault-close = "fusermount3 -u ~/.Vault";
    db-storage-open = "mkdir -p ~/.db-storage && gocryptfs ~/.db-cipher ~/.db-storage";
    db-storage-close = "fusermount3 -u ~/.db-storage";
  };
}