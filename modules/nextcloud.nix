# Applications
{ config, pkgs, ... }:
{
  imports = [
    ./sops-nix.nix
  ];

  sops.secrets.nextcloud_database = {
    owner = "nextcloud";
    group = "nextcloud";
    mode = "0400";
    sopsFile = ../secrets/nextcloud/secrets.yaml;
  };
  # -------------------- 
  # Syncthing
  # -------------------- 
  services.syncthing = {
    enable = true;
    openDefaultPorts = false;
  };

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
      adminpassFile = config.sops.secrets.nextcloud_database.path;
    };
  };

  # -------------------- 
  # Caddy SSL Cert
  # -------------------- 
  services.caddy = {
    enable = true;
    virtualHosts."nextcloud.tail590ac.ts.net".extraConfig = ''
      reverse_proxy 127.0.0.1:8080
    '';
    virtualHosts."syncthing.nextcloud.tail590ac.ts.net".extraConfig = ''
      reverse_proxy 127.0.0.1:8080
    '';
  };
  services.tailscale.permitCertUid = "caddy";
  services.nginx.virtualHosts."localhost".listen = [ { addr = "127.0.0.1"; port = 8080; } ];

}
