{ lib, pkgs, ... }:
{
  options.systemVars = {
    # Basic information
    username = lib.mkOption {
      type = lib.types.str;
      default = "mistflow";
      description = "Основной пользователь системы";
    };

    hostname = lib.mkOption {
      type = lib.types.str;
      default = "bluebird";
      description = "Имя hostname машины";
    };

    personalEmail = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Personal email address";
    };

    professionalEmail = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Professional/work email address";
    };

    personalGithubName = lib.mkOption {
      type = lib.types.str;
      default = "";
    };

    professionalGithubName = lib.mkOption {
      type = lib.types.str;
      default = "";
    };

    # Hardware / GUI
    diskDevice = lib.mkOption {
      type = lib.types.str;
      description = "Полный путь к основному диску (рекомендуется /dev/disk/by-id/)";
    };

    guiBuild = lib.mkOption {
      type = lib.types.enum [
        "niri-noctalia"
        "niri-dms"
      ];
      default = "niri-noctalia";
      description = "Which GUI build variant to use";
      example = "niri-dms";
    };

    # Features
    aiIntegrationLevel = lib.mkOption {
      type = lib.types.enum [
        "off"
        "conversational-only"
        "coding-only"
        "full"
      ];
      default = "off";
      description = ''
        Level of AI integration in the system.
        - off: AI completely disabled
        - conversational-only: Only chat/LLM features
        - coding-only: Only code assistance
        - full: All AI features enabled
      '';
      example = "full";
    };

    aiPreserveDirs = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Option for preserving ai-related dirs with data";
    };

    aiPreserveModels = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Option for preserving LLM models (turn off to save space)";
    };

    containerization = lib.mkOption {
      type = lib.types.enum [
        "docker"
        "podman"
        "off"
      ];
      default = "podman";
      description = ''
        Choosing either to enable Docker, Podman or turning it off
      '';
      example = "podman";
    };

    enabledDatabases = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "postgresql" "mongodb" "clickhouse" ];
      description = ''
        List of enabled database packages
      '';
      example = [ "postgresql" ];
    };

    isLaptop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Is this a laptop?";
    };
  };
}