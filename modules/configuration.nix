# Main Configuration
{ inputs, config, pkgs, ... }:

{ 
  imports =
    [ 
      <nixpkgs/nixos/modules/virtualization/lxc-container.nix>
      # --- Services ---
      ./general.nix
      #./photoprism.nix
      #./nextcloud.nix

      # --- System Configuration ---
      ./system/nix-package-configuration.nix
    ];
}
