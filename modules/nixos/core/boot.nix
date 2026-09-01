{ pkgs, lib, inputs, ... }:

{
  # ─────────────────────────────────────────────────────────────
  # Bootloader, Kernel и ранний этап загрузки (stage 1 / initrd)
  # ─────────────────────────────────────────────────────────────
  
  boot = {
    # ====================== GRUB Bootloader ======================
    loader = {
      # Общий таймаут (0 = сразу загружать последнее поколение, без меню)
      timeout = 0;
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = 8;
        editor = false;
        consoleMode = "auto";
      };
    };

    # ====================== Тихий и чистый ранний boot ======================
    consoleLogLevel = 3;           # Минимальный вывод логов ядра
    initrd.verbose = false;        # Отключаем verbose-режим в initrd

    # Дополнительные параметры ядра для ещё более тихой загрузки
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "udev.log_level=3"
      "amd_pstate=active"        
    ];
    
    kernelModules = [ "8250" ];  # оставляем драйвер
    extraModprobeConfig = ''
      blacklist serial8250
      options serial8250 nr_uarts=0
    '';

    # ====================== Kernel и initrd ======================
    # Раннее подключение драйвера AMD GPU (полезно для Hyprland/Wayland)
    #initrd.kernelModules = [ "amdgpu" ];

    # Используем свежий kernel от CachyOS (хорошо для современных AMD)
    #kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

    tmp.cleanOnBoot = true;
  };

  # Если хочешь ещё более ранний и стабильный Plymouth (рекомендуется при LUKS)
  boot.initrd.systemd.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
}