{
  description = "NixOS Server Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, ...}@inputs: 
    let
      system = "x86_64-linux";
    in { 
      nixosConfigurations = {
        backup = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; hostname = "backup"; };
          modules = [
            ./hosts/proxmox.nix
            ./modules/general-configuration.nix
          ];
        };

        etebase = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; hostname = "etebase"; };
          modules = [
            ./hosts/proxmox.nix
            ./modules/general-configuration.nix
            ./modules/etesync.nix
          ];
        };

        adguard = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; hostname = "adguard"; };
          modules = [
            ./hosts/proxmox.nix
            ./modules/general-configuration.nix
            ./modules/adguard.nix
          ];
        };

        immich = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; hostname = "immich"; };
          modules = [
            ./hosts/proxmox.nix
            ./modules/general-configuration.nix
            ./modules/immich.nix
          ];
        };

        nextcloud = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; hostname = "nextcloud"; };
          modules = [
            ./hosts/proxmox.nix
            ./modules/general-configuration.nix
            ./modules/nextcloud.nix
            ./modules/sops-nix.nix
          ];
        };

        calibre = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; hostname = "calibre"; };
          modules = [
            ./hosts/proxmox.nix
            ./modules/general-configuration.nix
            ./modules/calibre-server.nix
          ];
        };
      };
    };
}
