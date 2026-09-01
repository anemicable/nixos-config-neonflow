{ pkgs, ... }: {
  dconf.enable = true;  # Important on NixOS

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Optional: Extra GTK dark preference (helps with older GTK apps)
  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk3";
    # Optionally also:
    # QT_STYLE_OVERRIDE = "gtk";  # sometimes helps more
  };
}