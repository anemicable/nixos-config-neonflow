
{ pkgs, ... }:
{
  # ─────────────────────────────────────────────────────────────
  # Locale, Timezone & Input Methods
  # ─────────────────────────────────────────────────────────────

  # Timezone
  time.timeZone = "Europe/Moscow";

  # Default locale
  i18n.defaultLocale = "en_US.UTF-8";

  # ─────────────────────────────────────────────────────────────
  # Keyboard Layout
  # ─────────────────────────────────────────────────────────────
  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:ctrl_space_toggle";
  };

  console.useXkbConfig = true;

  # ─────────────────────────────────────────────────────────────
  # Input Method (fcitx5) - Chinese, Japanese, etc.
  # ─────────────────────────────────────────────────────────────
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;   # обязательно для Hyprland

      addons = with pkgs; [
        fcitx5-gtk                    # GTK
        kdePackages.fcitx5-qt         # Qt6 (Plasma 6)
        # qt6Packages.fcitx5-qt       # альтернатива, если kdePackages не тянет

        qt6Packages.fcitx5-chinese-addons   # ← вот это вместо fcitx5-chinese-addons
        fcitx5-rime
        rime-data

        fcitx5-hangul                 # корейский
        fcitx5-mozc                   # японский (по желанию)

        # fcitx5-configtool           # GUI-конфигуратор
      ];
    };
  };

  fonts = {
    enableDefaultPackages = true;   # Keeps basics like DejaVu, etc.

    packages = with pkgs; [
      hack-font
      nerd-fonts.hack
      nerd-fonts.symbols-only
      inter               # Your preferred Latin/UI font
      noto-fonts          # Base Noto family (good Latin too)
      noto-fonts-cjk-sans # Main package for Chinese (Simplified/Traditional)
      noto-fonts-cjk-serif # Optional: for serif Chinese text
      noto-fonts-color-emoji
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "DejaVu Sans" "Noto Sans CJK SC" ];      # SC = Simplified Chinese
        serif     = [ "DejaVu Serif" "Noto Serif CJK SC" ];
        monospace = [ "DejaVu Sans Mono" "Noto Sans Mono CJK SC" ];
      };
    };
  };
}