{ inputs, config, pkgs, hostname, ... }:

{ 
  imports = [
  ];
  networking.hostName = hostname;
  time.timeZone = "America/New_York";
  system.stateVersion = "25.05"; 
}
