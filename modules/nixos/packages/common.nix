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

    # === Сеть ===
    nmap
    tcpdump
    dig
    whois

    # === Nix-specific ===
    nix-tree
    nix-output-monitor
    nh                    # nix helper (очень удобно)

    adwaita-icon-theme

    weston
    xwayland
    wayland-utils

    openssl
    sops
    age
   ];
}