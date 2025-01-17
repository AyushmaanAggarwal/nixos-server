# Applications
{ config, pkgs, ... }:
{
  # -------------------- 
  # Various services
  # -------------------- 
  services.thermald.enable = true;
  services.tailscale = {
    enable = true;
    interfaceName = "userspace-networking";
    disableTaildrop = true;
  };
  programs.ssh.startAgent = true;
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.proxmox = { 
    isNormalUser = true; description = "Proxmox User"; 
    extraGroups = [ "networkmanager" "wheel" ]; 
    packages = with pkgs; [
      neovim
      htop
      powertop
      fastfetch
    ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEa53AGMV87VUquUKyQ2NlqmZiN7OVV438VLUe6hYJU2" ];
  };

  
  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [ 
    vim
    git
    gcc
    wget
  ];
}

