# Applications
{ config, pkgs, ... }:
{
  # --------------------
  # Tailscale Configuration Modifications
  # -------------------- 
  services.tailscale.useRoutingFeatures = "server";
  services.tailscale.extraSetFlags = [
    "--advertise-exit-node" 
    "--accept-dns=false" # Ensure tailscale doesn't interfere with adguard dns
  ];

  # -------------------- 
  # Adguard Configuration
  # -------------------- 
  services.adguardhome = {
    enable = true;
    host = "127.0.0.1";
    port = 3003;
    openFirewall = true;
    mutableSettings = false;
    settings = {
      dns = {
        bind_hosts = [
          "127.0.0.1"
        ];

        upstream_dns = [
          "https://dns.quad9.net/dns-query"
        ];

        bootstrap_dns = [ 
          "9.9.9.10"
          "149.112.112.10"
        ];
      };
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
        parental_enabled = false;  # Parental control-based DNS requests filtering.
        safe_search = {
          enabled = false;  # Enforcing "Safe search" option for search engines, when possible.
        };
      };
      filters = map(url: { enabled = true; url = url; }) [
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"  # The Big List of Hacked Malware Web Sites
        "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"  # malicious url blocklist
      ];
      schema_version = 29;
    };
  };

  # -------------------- 
  # Caddy SSL Cert
  # -------------------- 
  services.caddy = {
    enable = true;
    virtualHosts."adguard.tail590ac.ts.net".extraConfig = ''
      reverse_proxy 127.0.0.1:3003
    '';
 
  };
  services.tailscale.permitCertUid = "caddy";
}
