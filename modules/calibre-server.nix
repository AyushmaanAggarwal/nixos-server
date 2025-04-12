{ config, pkgs, ... }:
let 
  userdb-path = "/var/lib/calibre-server";
in
{
  # Need to generate file with `calibre-server --userdb users.sqlite --manage-users` 
  # if it doesn't exist already. Also copy usersdb into /var/lib/users.sqlite during installation
  system.activationScripts.script.text = ''
    mkdir ${userdb-path}
    chown calibre-server:calibre-server ${userdb-path}
    chmod 755 ${userdb-path}
  '';

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
      userDb = "${userdb-path}/users.sqlite";
    };
    openFirewall = false;
    libraries = [ "/var/lib/calibre-server/users.sqlite" ];
  };
  # -------------------- 
  # Caddy SSL Cert
  # -------------------- 
  services.caddy = {
    enable = true;
    virtualHosts."calibre.tail590ac.ts.net".extraConfig = ''
      reverse_proxy 127.0.0.1:8080
    '';
  };
  services.tailscale.permitCertUid = "caddy";
}
