# Applications
{ config, pkgs, ... }:
{
  # -------------------- 
  # Various services
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
 
  services.caddy = {
    enable = true;
    virtualHosts."nextcloud.tail590ac.ts.net".extraConfig = ''
      reverse_proxy http://127.0.0.1:8080
    '';
  };
  services.nginx.virtualHosts."localhost".listen = [ { addr = "127.0.0.1"; port = 8080; } ];
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "127.0.0.1";
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
