# Main Configuration
{ inputs, config, pkgs, ... }:

{ 
  imports =
    [ 
      # --- Services ---
      ./general.nix
      #./photoprism.nix
      #./nextcloud.nix

      # --- System Configuration ---
      ./system/nix-package-configuration.nix
    ];

  system.stateVersion = "25.05"; 
}
