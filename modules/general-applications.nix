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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.photoprism = { 
    isNormalUser = true; description = "Photoprism User"; 
    extraGroups = [ "networkmanager" "wheel" ]; 
    packages = with pkgs; [
      neovim
      htop
      powertop
      fastfetch
    ];
  };

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [ 
    vim
    git
    gcc
    wget
  ];
}

