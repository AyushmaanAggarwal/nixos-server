# Main Configuration
{ inputs, config, pkgs, ... }:

{ 
  imports =
    [ 
      # --- Services ---
      ./general-applications.nix

      # --- System Configuration ---
      ./nix-package-configuration.nix
      ./scripts.nix
    ];
}
