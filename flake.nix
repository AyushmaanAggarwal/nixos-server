{
  description = "NixOS Server Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }@inputs: 
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

        nixos-etebase = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            (nixpkgs + "/nixos/modules/virtualisation/proxmox-lxc.nix")
            ./hosts/etebase.nix
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
          ];
        };

      };
    };
}
