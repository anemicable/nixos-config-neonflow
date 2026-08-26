{ pkgs, lib, config, ... }:
{
  programs.niri.enable = true;

  # Используем свежую версию Niri только для DMS
  programs.niri.package = pkgs.niri;

  # Кэш niri
  nix.settings = {
    substituters = [ "https://niri.cachix.org" ];
    trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
  };

  #environment.systemPackages = with pkgs; [
  #  xwayland-satellite
  #  nautilus
  #];
}