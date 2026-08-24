{ pkgs, ... }:
{
    home.packages = with pkgs; [
    # Development
    neovim
    jetbrains.pycharm

    python312
    poetry
    ruff
    uv

    dbt

    dbeaver-bin

    # Containerization
    # docker-compose

    # Notification
    libnotify

    # Social apps
    telegram-desktop
    discord

    # Office apps
    libreoffice
    
    # Image viewer
    feh
    
    # User dirs
    xdg-user-dirs

    quickshell
  ];
}