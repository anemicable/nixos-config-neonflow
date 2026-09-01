{ config, lib, pkgs, ... }:
let
  aiLevel = config.systemVars.aiIntegrationLevel;
in
{ 
  # Создаём папки декларативно
  systemd.tmpfiles.rules = [
    "d /persistent/var/lib/ollama 0700 ollama ollama -"
    "d /persistent/var/lib/ollama/models 0700 ollama ollama -"
    #"d /persistent/var/lib/open-webui 0700 open-webui open-webui -"
  ];

  # === OLLAMA ===
  services.ollama = {
    enable = aiLevel != "off";
    package = pkgs.ollama-rocm;
    port = 11434;
    host = "0.0.0.0";
    user = "ollama";
    group = "ollama";

    home = "/persistent/var/lib/ollama";

    # Auto-download models when the service starts
    loadModels = [
      "mistral:latest"           # Good general-purpose default
      "qwen2.5:7b"               # Excellent all-rounder for roleplay & instructions
    ]

    # ==================== GENERAL / ROLEPLAY MODELS ====================
    ++ lib.optionals (aiLevel == "conversational-only" || aiLevel == "full") [
      # "llama3.2:3b"            # Very fast, lightweight
      # "gemma2:9b"              # Strong reasoning + creativity
      "qwen2.5:14b"            # High quality medium model
      # "mistral-nemo:12b"       # Good writing style

      # "deepseek-coder-v2:16b"  # Strong coding + reasoning
      # "qwen3-coder:8b"         # Newer Qwen coding variant, great for agents
      # "codestral:22b"          # Mistral's dedicated code model
      # "devstral:24b"           # Excellent for coding agents
      # "codegemma:7b"           # Lightweight code completion / generation
    ]
    
     # ==================== CODING MODELS ====================
    ++ lib.optionals (aiLevel == "coding-only" || aiLevel == "full") [
    # "qwen2.5-coder:7b"       # Best small coding model — fast & very capable
    # "qwen2.5-coder:14b"      # Excellent balance (highly recommended)
    # "qwen2.5-coder:32b"      # Top-tier coding performance (if you have enough VRAM)
    # "qwen2.5-coder:7b-q4_K_M" # Quantized version (smaller VRAM usage)
    ]
    
    # ==================== LARGE / HIGH QUALITY ====================
    ++ lib.optionals (aiLevel == "full") [
    # "qwen2.5:32b"            # Very strong general model
    # "llama3.3:70b"           # Meta's strong flagship (needs lots of VRAM)
    ];

    # Optional: Automatically remove models not listed above on rebuild
    # syncModels = true;
  };
  
  systemd.services.ollama = {
    after = [ 
      "systemd-tmpfiles-setup.service"
      "systemd-tmpfiles-setup-dev.service"
    ];
    requires = [ "systemd-tmpfiles-setup.service" ];
    serviceConfig.DynamicUser = lib.mkForce false;
  };

  networking.firewall.allowedTCPPorts = [
    config.services.ollama.port
    config.services.open-webui.port
  ];
}