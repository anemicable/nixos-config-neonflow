{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    # либо pkgs.vscode, либо pkgs.vscode.fhs на старте
    package = pkgs.vscode.fhs; # / pkgs.vscode.fhs

  };
}