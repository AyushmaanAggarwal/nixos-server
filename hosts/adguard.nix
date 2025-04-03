{ inputs, config, pkgs, ... }:

{ 
  networking.hostName = "nixos-adguard";
  time.timeZone = "America/New_York";
  system.stateVersion = "25.05"; 
}
