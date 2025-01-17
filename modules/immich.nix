# Applications
{ config, pkgs, ... }:
{
  # -------------------- 
  # Immich Service
  # -------------------- 
  services.immich = {
    enable = true;
    port = 2283;
  };

  # -------------------- 
  # Hardware Video Transcoding
  # -------------------- 
  users.users.immich.extraGroups = [ "video" "render" ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Optionally, set the environment variable

  # -------------------- 
  # Caddy SSL Cert
  # -------------------- 
  services.caddy = {
    enable = true;
    virtualHosts."immich.tail590ac.ts.net".extraConfig = ''
      reverse_proxy 127.0.0.1:2283
    '';
  };
  services.tailscale.permitCertUid = "caddy";
  
}
