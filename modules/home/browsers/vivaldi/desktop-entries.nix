{ config, ... }:
let
  # Purplemist
  vaultPathMoonflow = "${config.home.homeDirectory}/.db-storage";
  configPathMoonflow = "${config.home.homeDirectory}/.config";
in
{
    # ==================== Desktop Entries ====================
  xdg.desktopEntries = {
    vivaldi-moonflow = {
      name = "Vivaldi Moonflow";
      comment = "Основной, личный профиль";
      exec = builtins.concatStringsSep " " [
        "vivaldi"
        "--user-data-dir=${configPathMoonflow}/vivaldi-moonflow"
        "%U"
      ];
      icon = "${config.home.homeDirectory}/nixos-config/assets/icons/vivaldi-moonflow.png";
      terminal = false;
      type = "Application";
      categories = [ "Network" "WebBrowser" ];
    };
  };

  xdg.desktopEntries = {
    vivaldi-coding = {
      name = "Vivaldi (Coding)";
      comment = "Профиль для работы и обучения кодингу";
      exec = builtins.concatStringsSep " " [
        "vivaldi"
        "--user-data-dir=${configPathMoonflow}/vivaldi-coding"
        "%U"
      ];
      icon = "${config.home.homeDirectory}/nixos-config/assets/icons/vivaldi-coding.png";
      terminal = false;
      type = "Application";
      categories = [ "Network" "WebBrowser" ];
    };

    vivaldi-shopping = {
      name = "Vivaldi (Shopping)";
      comment = "Профиль для покупок";
      exec = builtins.concatStringsSep " " [
        "vivaldi"
        "--user-data-dir=${configPathMoonflow}/vivaldi-shopping"
        "%U"
      ];
      icon = "${config.home.homeDirectory}/nixos-config/assets/icons/vivaldi-shopping.png";
      terminal = false;
      type = "Application";
      categories = [ "Network" "WebBrowser" ];
    };
  };
}