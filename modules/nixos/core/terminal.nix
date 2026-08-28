{ pkgs, config, ... }:
let
  hostname = config.systemVars.hostname;
in
{
  programs.zsh.enable = true;
  console.colors = [
        #"#002b36"  # black
        #"#dc322f"  # red
        #"#859900"  # green
        #"#e7cbef"  # yellow
        #"#268bd2"  # blue
        #"#d33682"  # magenta
        #"#2aa198"  # cyan
        #"#eee8d5"  # white
        #"#002b36"  # bright black
        #"#cb4b16"  # bright red
        "000000"  # bright green
        #"#657b83"  # bright yellow
        #"#839496"  # bright blue
        #"#6c71c4"  # bright magenta
        #"#93a1a1"  # bright cyan
        #"#fdf6e3"  # bright white
  ];

  environment.shellAliases = {
    rebuild = "cd ~/nixos-config && sudo nixos-rebuild switch --flake .#${hostname}";
  };
}