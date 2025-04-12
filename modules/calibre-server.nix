{ config, pkgs, ... }:
let 
  user-database       = ../databases/calibre/users.sqlite;
  user-database-path  = "/var/lib/calibre-users/users.sqlite";
  calibre-library     = "/var/lib/calibre-server";
  calibre-port = 8080;
in
{
  # Copy users.sqlite
  systemd.calibreservice.serviceConfig = {
    User = "calibre-server";
    Group = "calibre-server";
    StateDirectory = "calibre-users";
    StateDirectoryMode = "0750";
  };

  system.activationScripts.script.text = ''
    cp --update=none ${user-database} ${user-database-path}
  '';

  # -------------------- 
  # Calibre Configuration
  # -------------------- 
  services.calibre-server = {
    enable = true;
    port = calibre-port;
    host = "127.0.0.1";
    auth = {
      enable = true;
      mode = "basic";
      # Need to generate file with `calibre-server --userdb /srv/calibre/users.sqlite --manage-users` if it doesn't exist already
      userDb = user-database-path;
    };
    openFirewall = false;
    libraries = [ calibre-library ];
  };
  # -------------------- 
  # Caddy SSL Cert
  # -------------------- 
  services.caddy = {
    enable = true;
    virtualHosts."calibre.tail590ac.ts.net".extraConfig = ''
      reverse_proxy 127.0.0.1:${calibre-port}
    '';
 
  };
  services.tailscale.permitCertUid = "caddy";
}
