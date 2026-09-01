{ config, osConfig, pkgs, lib, ... }:

{
  imports = [
    ../../modules/home/core/default.nix
  ];

  # === Динамические переменные ===
  home.username = osConfig.systemVars.username;
  home.homeDirectory = lib.mkForce "/home/${osConfig.systemVars.username}";

  home.stateVersion = "26.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXOS_OZONE_WL = "1";
  };
  programs.home-manager.enable = true;
}