{ ... }:

{
  imports = [
    ./sops-nix.nix
    ./openssh.nix
    ./gocryptfs.nix
    ./wraith-vault.nix
  ];
}
