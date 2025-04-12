{ config, pkgs, ... }:
let 
  userdb-path = "/var/lib/calibre-users";
in
{

  users.users.calibre-server = { 
    isNormalUser = true; description = "Calibre Database User"; # Used as a minimal remote builder
    hashedPassword = "$y$j9T$U4oMCo07HUSdkI5J7.veN0$M5IQppuGp0GoajLrg6glxPs9uiUJ5kpaFurh7SdmwH.";
  };

  # Need to generate file with `calibre-server --userdb /srv/calibre/users.sqlite --manage-users` 
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
    libraries = [ "/var/lib/calibre-server" ];
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
