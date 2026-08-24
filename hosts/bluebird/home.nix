{ config, osConfig, pkgs, lib, ... }:

{
  imports = [
    ./home-packages.nix
    ../../modules/home-manager/core/default.nix
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