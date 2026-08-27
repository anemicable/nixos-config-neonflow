{ config, pkgs, lib, osConfig, ... }: {
  imports = 
     [
      ./keybindings.nix
    ];

  programs.niri = {
    settings = {
      input.keyboard.xkb = {
        layout = "us,ru";
        options = "grp:ctrl_space_toggle";
      };

      layout = {
        gaps = 16;
        struts = {
          left = 8; right = 8; top = 8; bottom = 8;
        };
        focus-ring = {
          enable = true;
          width = 3;
          active.color = "#c4a5d988";
          inactive.color = "#50505088";
          urgent.color = "#9b0000";
        };
        shadow = {
          enable = true;
          softness = 25;
          offset = { x = 0; y = 8; };
          color = "#00000055";
        };
      };

      window-rules = [
        {
          matches = [ { } ];
          geometry-corner-radius = {
            top-left = 14.0;
            top-right = 14.0;
            bottom-right = 14.0;
            bottom-left = 14.0;
          };
          clip-to-geometry = true;
        }
      ];

      layout = {
        background-color = "transparent";
      };

      animations = {
        window-open.kind.spring = {
          damping-ratio = 0.65;
          stiffness = 280;
          epsilon = 0.0001;
        };
        window-close.kind.spring = {
          damping-ratio = 0.75;
          stiffness = 320;
          epsilon = 0.0001;
        };
        horizontal-view-movement.kind.spring = {
          damping-ratio = 0.70;
          stiffness = 260;
          epsilon = 0.0001;
        };
        window-movement.kind.spring = {
          damping-ratio = 0.80;
          stiffness = 300;
          epsilon = 0.0001;
        };
        window-resize.kind.spring = {
          damping-ratio = 0.65;
          stiffness = 250;
          epsilon = 0.0001;
        };
        overview-open-close.kind.spring = {
          damping-ratio = 0.75;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };

      # Spawn-at-startup — можно сделать тоже условным
      spawn-at-startup = [
        { command = ["nm-applet"]; }
        { command = ["fcitx5"]; }
      ] ++ lib.optionals (osConfig.systemVars.guiBuild == "niri-noctalia") [
        { command = ["noctalia-shell"]; }
      ];

      prefer-no-csd = true;
      cursor.hide-when-typing = true;
    };
  };
}