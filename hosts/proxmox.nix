{ inputs, config, pkgs, ... }:

{ 
  imports = [
    (pkgs + "/nixos/modules/virtualisation/proxmox-lxc.nix")
  ];
  networking.hostName = config.hostname;
  time.timeZone = "America/New_York";
  system.stateVersion = "25.05"; 
}
