{ pkgs, config, lib, ... }:

{

programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ]; 

    # Add your custom stuff here
    initContent = lib.mkAfter ''
      export PATH="$HOME/.local/bin:$PATH"
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      # Source your p10k config (generate it once with `p10k configure`)
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      # Optional: force a newline before prompt in p10k
      typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

    '';
  
 };

home.sessionPath = [
  "${config.home.homeDirectory}/.local/bin"
];

programs.ghostty = {
  enable = true;
  settings = {
    # Basic appearance
    background = "#101010";
    font-family = "Hack Nerd Font";  # Use a Nerd Font for icons/powerline
    font-size = 9;
    adjust-cell-height =  1;
    
    window-padding-x = 15;
    window-padding-y = 15;
    window-padding-balance = true;

    background-opacity = 0.95;
    background-blur-radius = 20;
    
    # Window Behavior
    window-save-state = "always";

    # Performance / Features
    cursor-style = "block";
    shell-integration = "zsh";         # or "fish", "bash", "detect"

    # Keybindings (example: better splits or tmux-like)
    # You can add any option from the official reference
  };
};

programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      continuum
      # add more from tmuxPlugins.*
    ];
    extraConfig = ''
    # Your custom settings here
    set -g mouse on
    set -g default-terminal "tmux-256color"
  '';
 };

  programs.fzf.enableZshIntegration = true;
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enableZshIntegration = true;
  };

}