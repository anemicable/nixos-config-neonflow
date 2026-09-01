{ pkgs, ... }:
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    neovim
    htop
    btop
    curl
    wget
    ripgrep
    fd
    fzf
    bat
    eza
    tree
    unzip
    p7zip

    fastfetch 

    # === Системные утилиты ===
    lsof
    strace
    ltrace
    pciutils
    usbutils
    lm_sensors
    speedtest-cli

    # === Сеть ===
    nmap
    tcpdump
    dig
    whois
    killall

    # === Nix-specific ===
    nix-tree
    nix-output-monitor
    nh                    # nix helper (очень удобно)

    adwaita-icon-theme
    
    vlc

    xwayland
    wayland-utils

    gocryptfs

    openssl
    sops
    age
   ];
}