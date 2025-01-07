{
  description = "NixOS Server Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs: 
    let
      system = "x86_64-linux";
    in { 
      nixosConfigurations.ayu = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          (nixpkgs + "/nixos/modules/virtualisation/lxc-container.nix")
          ./modules/configuration.nix
        ];
      };
    };
}
