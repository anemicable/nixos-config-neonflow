{ pkgs, ... }:
{
  services.hardware.bolt.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Steam / Proton
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "thunderbolt" "amdgpu" ];

  # на случай «не хватает bus numbers» у TB-дока
  boot.kernelParams = [
    "amdgpu.si_support=1" # безвредно
  ];

  hardware.amdgpu.initrd.enable = true;

  environment.systemPackages = with pkgs; [
    vulkan-tools
    mesa-demos
    clinfo
    pciutils
    bolt
    libva-utils
  ];
}