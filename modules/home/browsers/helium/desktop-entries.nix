{ pkgs, config, ... }:
{
  # ====================== Desktop entry ======================
  xdg.desktopEntries.helium-cryonic = {
    name = "Helium (Cryonic)";
    comment = "Профиль внутри ~/.Vault";
    exec = "${config.home.homeDirectory}/.local/bin/helium-cryonic %U";
    icon = "/persist/home/mistflow/nixos-config/assets/icons/helium-cryonic.png";
    terminal = false;
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
  };

  xdg.desktopEntries.helium-workstation = {
    name = "Helium (Workstation)";
    comment = "Профиль внутри ~/.Vault";
    exec = "${config.home.homeDirectory}/.local/bin/helium-workstation %U";
    icon = "security-high";
    terminal = false;
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
  };

  xdg.desktopEntries.helium-shopping = {
    name = "Helium (Shopping)";
    comment = "Профиль внутри ~/.Vault";
    exec = "${config.home.homeDirectory}/.local/bin/helium-shopping %U";
    icon = "security-high";
    terminal = false;
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
  };
}