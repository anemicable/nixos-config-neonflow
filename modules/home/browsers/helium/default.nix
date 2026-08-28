{ pkgs, config, ... }:
let
  vaultCipher = "${config.home.homeDirectory}/.vault-cipher";
  vaultMount  = "${config.home.homeDirectory}/.Vault";
  heliumDir   = "${vaultMount}/helium";

  zenity    = "${pkgs.zenity}/bin/zenity";
  gocryptfs = "${pkgs.gocryptfs}/bin/gocryptfs";
  notify    = "${pkgs.libnotify}/bin/notify-send";
in
{
  imports = [ ./desktop-entries.nix ];

  home.packages = [
    pkgs.gocryptfs
    pkgs.zenity
    pkgs.libnotify
    pkgs.fuse
  ];

  home.file.".local/bin/helium-cryonic" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      CIPHER="${vaultCipher}"
      VAULT="${vaultMount}"
      DATA="${heliumDir}"

      ask_pass() {
        ${zenity} --password \
          --title="Helium (Cryonic)" \
          --text="Пароль от ~/.Vault"
      }

      if ! mountpoint -q "$VAULT"; then
        mkdir -p "$CIPHER" "$VAULT"

        if [ ! -f "$CIPHER/gocryptfs.conf" ]; then
          if ! ${zenity} --question \
            --title="Helium Secure" \
            --text="Хранилище ещё не создано. Инициализировать ~/.Vault.cipher?"; then
            exit 1
          fi
          ask_pass | ${gocryptfs} -init -q "$CIPHER"
        fi

        if ! ask_pass | ${gocryptfs} -q "$CIPHER" "$VAULT"; then
          ${notify} "Helium Secure" "Неверный пароль или ошибка монтирования"
          exit 1
        fi
      fi

      mkdir -p "$DATA"
      exec helium \
        --user-data-dir="$DATA" \
        --no-first-run \
        --no-default-browser-check \
        --profile-directory=Cryonic \
        "$@"
    '';
  };

  home.file.".local/bin/helium-workstation" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      CIPHER="${vaultCipher}"
      VAULT="${vaultMount}"
      DATA="${heliumDir}"

      ask_pass() {
        ${zenity} --password \
          --title="Helium (Workstation)" \
          --text="Пароль от ~/.Vault"
      }

      if ! mountpoint -q "$VAULT"; then
        mkdir -p "$CIPHER" "$VAULT"

        if [ ! -f "$CIPHER/gocryptfs.conf" ]; then
          if ! ${zenity} --question \
            --title="Helium (Workstation)" \
            --text="Хранилище ещё не создано. Инициализировать ~/.Vault.cipher?"; then
            exit 1
          fi
          ask_pass | ${gocryptfs} -init -q "$CIPHER"
        fi

        if ! ask_pass | ${gocryptfs} -q "$CIPHER" "$VAULT"; then
          ${notify} "Helium Secure" "Неверный пароль или ошибка монтирования"
          exit 1
        fi
      fi

      mkdir -p "$DATA"
      exec helium \
        --user-data-dir="$DATA" \
        --no-first-run \
        --no-default-browser-check \
        --profile-directory=Workstation \
        "$@"
    '';
  };

  home.file.".local/bin/helium-shopping" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      CIPHER="${vaultCipher}"
      VAULT="${vaultMount}"
      DATA="${heliumDir}"

      ask_pass() {
        ${zenity} --password \
          --title="Helium (Shopping)" \
          --text="Пароль от ~/.Vault"
      }

      if ! mountpoint -q "$VAULT"; then
        mkdir -p "$CIPHER" "$VAULT"

        if [ ! -f "$CIPHER/gocryptfs.conf" ]; then
          if ! ${zenity} --question \
            --title="Helium Secure" \
            --text="Хранилище ещё не создано. Инициализировать ~/.Vault.cipher?"; then
            exit 1
          fi
          ask_pass | ${gocryptfs} -init -q "$CIPHER"
        fi

        if ! ask_pass | ${gocryptfs} -q "$CIPHER" "$VAULT"; then
          ${notify} "Helium Secure" "Неверный пароль или ошибка монтирования"
          exit 1
        fi
      fi

      mkdir -p "$DATA"
      exec helium \
        --user-data-dir="$DATA" \
        --no-first-run \
        --no-default-browser-check \
        --profile-directory=Shopping \
        "$@"
    '';
  };

  home.file.".local/bin/helium-swamp" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      CIPHER="${vaultCipher}"
      VAULT="${vaultMount}"
      DATA="${heliumDir}"

      ask_pass() {
        ${zenity} --password \
          --title="Helium (Swamp)" \
          --text="Пароль от ~/.Vault"
      }

      if ! mountpoint -q "$VAULT"; then
        mkdir -p "$CIPHER" "$VAULT"

        if [ ! -f "$CIPHER/gocryptfs.conf" ]; then
          if ! ${zenity} --question \
            --title="Helium Secure" \
            --text="Хранилище ещё не создано. Инициализировать ~/.Vault.cipher?"; then
            exit 1
          fi
          ask_pass | ${gocryptfs} -init -q "$CIPHER"
        fi

        if ! ask_pass | ${gocryptfs} -q "$CIPHER" "$VAULT"; then
          ${notify} "Helium Secure" "Неверный пароль или ошибка монтирования"
          exit 1
        fi
      fi

      mkdir -p "$DATA"
      exec helium \
        --user-data-dir="$DATA" \
        --no-first-run \
        --no-default-browser-check \
        --profile-directory=Swamp \
        --incognito \
        "$@"
    '';
  };
}