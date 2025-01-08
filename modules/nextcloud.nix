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
 
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "nextcloud.tail590ac.ts.net";
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
