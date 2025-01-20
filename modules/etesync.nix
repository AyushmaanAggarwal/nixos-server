# Applications
{ config, pkgs, ... }:
{
  # -------------------- 
  # Etebase Server Setup
  # -------------------- 
  services.etebase-server = {
    enable = true;
    port = 8001;
    settings = {
      allowed_hosts = {
        allowed_host1 = "127.0.0.1";
        allowed_host2 = "etebase.tail590ac.ts.net";
      };
      global.secret_file = "/var/lib/etebase-server/secret_file";
    };
  };


  # -------------------- 
  # Caddy SSL Cert
  # -------------------- 
  services.caddy = {
    enable = true;
    virtualHosts."etebase.tail590ac.ts.net".extraConfig = ''
      reverse_proxy 127.0.0.1:8001
    '';
  };
  services.tailscale.permitCertUid = "caddy";
}
