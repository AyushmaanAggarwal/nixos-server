# Applications
{ config, pkgs, ... }:
{
  # -------------------- 
  # Calibre Configuration
  # -------------------- 
  services.calibre-server = {
    enable = true;
    port = 8080;
    host = "127.0.0.1";
    auth = {
      enable = true;
      mode = "basic";
      # Need to generate file with `calibre-server --userdb /srv/calibre/users.sqlite --manage-users` if it doesn't exist already
      userDb = ../databases/calibre/users.sqlite;
    };
    openFirewall = true;
    libraries = [ "/var/lib/calibre-server" ];
  };
  services.calibre-web = {
    enable = true;
    listen = {
      ip = "127.0.0.1";
      port = 8100;
    };
    dataDir = "calibre-web";
    options = {
      enableBookUploading = true;
      enableKepubify = false;
      calibreLibrary = "/var/lib/calibre-server";
      enableBookConversion = true;
    };
    openFirewall = false;
  };
  # -------------------- 
  # Caddy SSL Cert
  # -------------------- 
  services.caddy = {
    enable = true;
    virtualHosts."calibre.tail590ac.ts.net".extraConfig = ''
      reverse_proxy /server* 127.0.0.1:8080
      reverse_proxy /web* 127.0.0.1:8080
    '';
 
  };
  services.tailscale.permitCertUid = "caddy";
}
