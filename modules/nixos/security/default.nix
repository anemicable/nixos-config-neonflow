{ ... }:

{
  imports = [
    ./sops-nix.nix
    ./openssh.nix
    ./gocryptfs.nix
    ./wireguard.nix
  ];
}
