{ pkgs, config, lib, ... }:
let
  gui = config.systemVars.guiBuild;
  isGnome = gui == "gnome";
  isNiri = builtins.elem gui [ "niri-dms" "niri-noctalia" ];
in {
  # Полный GNOME — только в профиле gnome
  services.desktopManager.gnome.enable = isGnome;
  #services.displayManager.gdm.enable = lib.mkDefault isGnome;

  services.gnome.core-apps.enable = isGnome;
  services.gnome.core-developer-tools.enable = isGnome;
  services.gnome.games.enable = false;

  # Куски, которые нужны и GNOME, и niri
  programs.dconf.enable = isGnome || isNiri;
  security.polkit.enable = isGnome || isNiri;
  services.gnome.gnome-keyring.enable = isGnome || isNiri;

  # GUI к связке ключей — по желанию, не обязателен для niri
  programs.seahorse.enable = isGnome;

  # Niri: порталы. programs.niri.enable уже тянет gnome portal + keyring,
  # это на случай если niri включаешь в другом модуле.
  xdg.portal = lib.mkIf isNiri {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome pkgs.xdg-desktop-portal-gtk ];
    config.niri = {
      default = [ "gnome" "gtk" ];
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      # иначе portal-gnome с 47+ зовёт Nautilus
      "org.freedesktop.impl.portal.FileChooser" = "gtk";
    };
  };
}