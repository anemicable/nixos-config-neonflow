{ pkgs, config, ... }:
{
  # ====================== Desktop entry ======================
  xdg.desktopEntries.helium-cryonic = {
    name = "Helium (Cryonic)";
    comment = "Основной профиль";
    exec = "${config.home.homeDirectory}/.local/bin/helium-cryonic %U";
    icon = "/persist/home/mistflow/nixos-config/assets/icons/helium-cryonic.jpg";
    terminal = false;
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
  };

  xdg.desktopEntries.helium-workstation = {
    name = "Helium (Workstation)";
    comment = "Рабочий / обучительный профиль";
    exec = "${config.home.homeDirectory}/.local/bin/helium-workstation %U";
    icon = "/persist/home/mistflow/nixos-config/assets/icons/helium-workstation.jpg";
    terminal = false;
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
  };

  xdg.desktopEntries.helium-shopping = {
    name = "Helium (Shopping)";
    comment = "Профиль для онлайн-покупок";
    exec = "${config.home.homeDirectory}/.local/bin/helium-shopping %U";
    icon = "/persist/home/mistflow/nixos-config/assets/icons/helium-shopping.jpg";
    terminal = false;
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
  };

  xdg.desktopEntries.helium-swamp = {
    name = "Helium (Swamp)";
    comment = "Профиль для остального";
    exec = "${config.home.homeDirectory}/.local/bin/helium-swamp %U";
    icon = "/persist/home/mistflow/nixos-config/assets/icons/helium-swamp.jpg";
    terminal = false;
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
  };
}