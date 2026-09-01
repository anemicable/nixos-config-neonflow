{ pkgs, ... }:
{
  imports = [
    ./ollama.nix
    ./silly-tavern.nix
    #./open-webui.nix
  ];
}
