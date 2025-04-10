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

  # Disable bad systemd units
  systemd.suppressedSystemUnits = [
    #"dev-mqueue.mount"
    "sys-kernel-debug.mount"
    #"sys-fs-fuse-connections.mount"
  ];

  # -------------------- 
  # Users
  # -------------------- 
  users.users = {
    nixadmin = { 
      isNormalUser = true; description = "Nixpkgs User"; # Used as a minimal remote builder
      extraGroups = [ "wheel" ];
      hashedPassword = "$y$j9T$MsKPpS9seZjFQTddCHJ.g0$WeGelFn99zcnxhW.QdoIC.ZslQLxgBm4a7sQKdfBdC7";
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEa53AGMV87VUquUKyQ2NlqmZiN7OVV438VLUe6hYJU2" ];
    };

    proxmox = { 
      isNormalUser = true; description = "Proxmox User"; # Primary non-root user in container
      extraGroups = [ "networkmanager" "wheel" ]; 
      packages = with pkgs; [
        neovim
        htop
        powertop
        fastfetch
      ];
      hashedPassword = "$y$j9T$nuV.3iXRhPpKvTXd94fFh.$9g4xyPrktivR.wpwUxT4P69bs0NLLAe2sDWDIjus5c4";
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEa53AGMV87VUquUKyQ2NlqmZiN7OVV438VLUe6hYJU2" ];
    };
  };

  
  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [ 
    vim
    git
    gcc
    wget
    bash
  ];
}

