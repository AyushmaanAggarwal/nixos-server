# Main Configuration
{ inputs, config, pkgs, ... }:

{ 
  imports =
    [ 
      # --- Services ---
      ./general-applications.nix
      #./photoprism.nix
      #./nextcloud.nix
      #./immich.nix
      #./etesync.nix

      # --- System Configuration ---
      ./nix-package-configuration.nix
      ./scripts.nix
    ];

  system.stateVersion = "25.05"; 
}
