# Applications
{ config, pkgs, ... }:
{
  # -------------------- 
  # Various services
  # -------------------- 

  users.users.nextcloud = { 
    isNormalUser = true; 
    description = "Nextcloud User"; 
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
