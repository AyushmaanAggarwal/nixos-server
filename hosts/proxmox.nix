{ inputs, config, pkgs, hostname, modulesPath, ... }:
{ 
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];
  networking.hostName = hostname;
  time.timeZone = "America/New_York";
  system.stateVersion = "25.05"; 
}
