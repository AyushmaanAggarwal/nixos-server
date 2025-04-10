{ inputs, config, pkgs, ... }:
{
  # Enable Flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };
 
  nix.settings.trusted-users = [ "nixadmin" ];

  # Automatically update system
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "05:00";
  };

  # Collect garbage
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 30d";
  };
}
