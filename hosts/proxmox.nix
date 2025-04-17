{ inputs, config, pkgs, hostname, ... }:

{ 
  imports = [
    (pkgs + "/virtualisation/proxmox-lxc.nix")
  ];
  networking.hostName = hostname;
  time.timeZone = "America/New_York";
  system.stateVersion = "25.05"; 
}
