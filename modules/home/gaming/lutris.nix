
{ pkgs, ... }:

{
  programs.lutris = {
    enable = true;
    package = pkgs.lutris.override {
      extraLibraries = p: with p; [
        gamemode
        mangohud
        libGL
        libGLU
        openal
        vulkan-loader
        libxcursor
        libxi
        libxinerama
        libxrandr
        libxkbcommon
        # добавляй сюда по мере возникновения ошибок
      ];

     extraPkgs = p: with p; [
        wineWowPackages.stagingFull
        winetricks
      ];
    };
  };
}