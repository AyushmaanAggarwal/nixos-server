# Applications
{ config, pkgs, ... }:
{
  # -------------------- 
  # Various services
  # -------------------- 
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "nextcloud.tail590ac.ts.net";
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
    };
    extraAppsEnable = true;

    database.createLocally = true;
    config = {
      dbtype = "pgsql";
      adminpassFile = "/home/proxmox/.secrets/nextcloud-admin-pass";
    };
  };
}
