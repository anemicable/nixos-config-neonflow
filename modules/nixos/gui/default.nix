{ ... }:
{
  imports = [
    #./gnome/default.nix
    ./niri.nix

    ./display-manager.nix
  ];

  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;
}