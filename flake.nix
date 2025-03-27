{
  description = "NixOS Server Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs: 
    let
      system = "x86_64-linux";
    in { 
      nixosConfigurations = {
        nixos-etebase = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            (nixpkgs + "/nixos/modules/virtualisation/lxc-container.nix")
            ./hosts/etebase.nix
            ./modules/general-configuration.nix
            ./modules/etesync.nix
          ];
        };

        nixos-immich = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            (nixpkgs + "/nixos/modules/virtualisation/lxc-container.nix")
            ./hosts/immich.nix
            ./modules/general-configuration.nix
            ./modules/immich.nix
          ];
        };

        nixos-nextcloud = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            (nixpkgs + "/nixos/modules/virtualisation/lxc-container.nix")
            ./hosts/nextcloud.nix
            ./modules/general-configuration.nix
            ./modules/nextcloud.nix
          ];
        };

      };
    };
}
