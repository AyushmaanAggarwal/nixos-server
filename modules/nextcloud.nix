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
 
  let 
    nc = pkgs.nextcloud30;
  in
    services.nextcloud = {
      enable = true;
      package = nc;
      hostName = "nextcloud.tail590ac.ts.net";
      extraApps = {
        inherit (nc.packages.apps) news contacts calendar tasks;
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
