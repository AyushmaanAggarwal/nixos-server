{ inputs, config, pkgs, ... }:

{ 
  networking.hostName = "nixos-immich";
  time.timeZone = "America/New_York";
  system.stateVersion = "25.05"; 
}
