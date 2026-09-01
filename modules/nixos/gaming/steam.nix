{ pkgs, lib, ... }:

{
  # ── Steam & Gaming ─────────────────────────────────────
  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;

}