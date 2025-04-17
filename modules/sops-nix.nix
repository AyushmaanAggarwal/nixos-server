# Applications
{ inputs, config, pkgs, hostname, user, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../secrets/${hostname}.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/ayushmaan/.config/sops/age/keys.txt";
  };
}

