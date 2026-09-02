{ config, lib, inputs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
  };

  # ───────────────────────────────────────────────────────────────────────
  # NOCTALIA CONFIGURATION (Impermanent-friendly)
  # ───────────────────────────────────────────────────────────────────────
  xdg.configFile."DankMaterialShell" = {
    source = config.lib.file.mkOutOfStoreSymlink
   "${config.home.homeDirectory}/nixos-config/config/noctalia";  
   force = true;
  };
}
