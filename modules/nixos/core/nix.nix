{ ... }:

{
  # ─────────────────────────────────────────────────────────────
  # Nix Configuration
  # ─────────────────────────────────────────────────────────────

  # Modern Nix CLI features (highly recommended)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow installation of unfree (proprietary) packages
  # Needed for things like NVIDIA drivers, Steam, Discord, etc.
  nixpkgs.config.allowUnfree = true;

  # Nix daemon / store settings
  nix.settings = {
    # Automatically deduplicate identical files in the store using hard links
    # Saves a lot of disk space (often 20-40%) with almost no downside
    auto-optimise-store = true;

    # Keep outputs and derivations from builds
    # Makes it easier and faster to rollback or rebuild things later
    keep-outputs = true;
    keep-derivations = true;

    # Binary caches (substituters) to speed up downloads
    # You can add more community caches here if needed
    substituters = [
      "https://cache.nixos.org/"
      "https://attic.xuyh0120.win/lantian"
      "https://noctalia.cachix.org"
    ];
    
    # Public keys to verify the authenticity of the above caches
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];

    # Optional: Increase download buffer for faster large downloads
    # download-buffer-size = 128 * 1024 * 1024; # 128 MiB
  };

  # Automatic garbage collection
  # Runs weekly and removes old generations + unreferenced store paths
  nix.gc = {
    automatic = true;                    # Enable the systemd timer
    dates = "weekly";                    # You can also use "daily" or "03:15" etc.
    options = "--delete-older-than 7d"; # Keep only the last 30 days of generations
    persistent = true;                   # Run missed GCs on next boot (great for laptops)
  };

  nixpkgs.overlays = [
    (final: prev: {
      openldap = prev.openldap.overrideAttrs (old: {
        doCheck = false;
        doInstallCheck = false;
      });
    })
  ];

  # Optional: Use a more recent version of Nix itself
  # nix.package = pkgs.nixVersions.latest;

  # Note: nix.channel.enable is no longer necessary for most users
  # (especially if you're using flakes). It can be safely omitted unless
  # you still rely on legacy `nix-channel` commands.
}