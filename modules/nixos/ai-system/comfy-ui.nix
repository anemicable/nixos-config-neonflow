{
  imports = [ inputs.comfyui-nix.nixosModules.default ];

  services.comfyui = {
    enable = true;
    gpuSupport = "rocm";   # or "rocm" / "none"
    enableManager = true;  # ComfyUI Manager for custom nodes
    port = 8188;
    # dataDir = "/var/lib/comfyui";  # default
    # listenAddress = "127.0.0.1";   # change to 0.0.0.0 if you want LAN access
  };
}