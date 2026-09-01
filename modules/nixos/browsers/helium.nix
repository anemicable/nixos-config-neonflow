{ inputs, config, ... }:
let
  vaultPath = "${config.home.homeDirectory}/Data/.sync/.helium-cryonic";
  mountPath = "${config.home.homeDirectory}/.config/helium-cryonic";
in
{
  imports = [ inputs.helium.nixosModules.default ];

  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
    ];
    policies = {
      PasswordManagerEnabled = false;
      SyncDisabled = true;
    };
  };
}