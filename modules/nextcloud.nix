# Applications
{ config, pkgs, ... }:
{
  # -------------------- 
  # Nextcloud Password File
  # -------------------- 
  environment.etc."secrets/nextcloud-admin-pass" = {
    reminder to fill in secret below
    text = ''
    <fill in secret>
    '';
    user = "nextcloud";
    group = "nextcloud";
    mode = "0400";
  };

  # -------------------- 
  # Caddy SSL Cert
  # -------------------- 
  services.caddy = {
    enable = true;
    virtualHosts."nextcloud.tail590ac.ts.net".extraConfig = ''
      reverse_proxy 127.0.0.1:8080
    '';
  };
  services.tailscale.permitCertUid = "caddy";
  services.nginx.virtualHosts."localhost".listen = [ { addr = "127.0.0.1"; port = 8080; } ];

  # -------------------- 
  # Nextcloud Configuration
  # -------------------- 
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "localhost";
    settings.trusted_domains = [ "nextcloud.tail590ac.ts.net" ];
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
    };
    extraAppsEnable = true;
    autoUpdateApps.enable = true;

    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminuser = "admin";
      adminpassFile = "/etc/secrets/nextcloud-admin-pass";
    };
  };
}
