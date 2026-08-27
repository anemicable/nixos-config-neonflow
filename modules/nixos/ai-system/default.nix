{ pkgs, ... }:
{
  imports = [
    ./ollama.nix
    #./sillytavern/default.nix
    ./open-webui.nix
  ];
}