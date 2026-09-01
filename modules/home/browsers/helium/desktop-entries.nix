{ pkgs, config, ... }:
let
  cryonicPath = "/home/mistflow/.config/helium/";
in
{
  # ====================== Desktop entry ======================
  xdg.desktopEntries.helium-cryonic = {
    name = "Helium (Cryonic)";
    comment = "Основной профиль";
    exec = builtins.concatStringsSep " " [
        "helium"
        "--user-data-dir=${cryonicPath}/Cryonic"
        "%U"
      ];
    icon = "/persist/home/mistflow/nixos-config/assets/icons/helium-cryonic.jpg";
    terminal = false;
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
  };
}