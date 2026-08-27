{ pkgs, ... }:
{
  environment.shellAliases = {
    vault-open = "mkdir -p ~/.Vault && gocryptfs ~/.vault-cipher ~/.Vault";
    vault-close = "fusermount3 -u ~/.Vault";
  };
}