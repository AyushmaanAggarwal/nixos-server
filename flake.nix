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
        nixos-backup = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            (nixpkgs + "/nixos/modules/virtualisation/proxmox-lxc.nix")
            ./hosts/backup.nix
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

        nixos-adguard = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            (nixpkgs + "/nixos/modules/virtualisation/proxmox-lxc.nix")
            ./hosts/adguard.nix
            ./modules/general-configuration.nix
            ./modules/adguard.nix
          ];
        };

        nixos-immich = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            (nixpkgs + "/nixos/modules/virtualisation/proxmox-lxc.nix")
            ./hosts/immich.nix
            ./modules/general-configuration.nix
            ./modules/immich.nix
          ];
        };

        nixos-nextcloud = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            (nixpkgs + "/nixos/modules/virtualisation/proxmox-lxc.nix")
            ./hosts/nextcloud.nix
            ./modules/general-configuration.nix
            ./modules/nextcloud.nix
            inputs.sops-nix.nixosModules.sops
          ];
        };

        nixos-calibre = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            (nixpkgs + "/nixos/modules/virtualisation/proxmox-lxc.nix")
            ./hosts/calibre.nix
            ./modules/general-configuration.nix
            ./modules/calibre-server.nix
          ];
        };


      };
    };
}
