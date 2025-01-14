# Main Configuration
{ inputs, config, pkgs, ... }:

{ 
  imports =
    [ 
      # --- Services ---
      ./general-applications.nix
      #./photoprism.nix
      #./nextcloud.nix

      # --- System Configuration ---
      ./nix-package-configuration.nix
    ];

  system.stateVersion = "25.05"; 
}
