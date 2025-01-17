# Applications
{ config, pkgs, ... }:
{
  # -------------------- 
  # Etebase Server Setup
  # -------------------- 
  services.etebase-server = {
    enable = true;
    settings = {
      allowed_hosts = {
        allowed_host2 = "etebase.tail590ac.ts.net";
        allowed_host1 = "127.0.0.1";
      };
      global.secret_file = "/home/etebase-server/.secret_file";
    };
  };


  # -------------------- 
  # Caddy SSL Cert
  # -------------------- 
  services.caddy = {
    enable = true;
    virtualHosts."etebase.tail590ac.ts.net".extraConfig = ''
      reverse_proxy 127.0.0.1:8001
        header_up Host {upstream_hostport}
    '';
  };
  services.tailscale.permitCertUid = "caddy";
}
