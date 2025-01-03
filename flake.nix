{
  description = "fuck this shit";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      homeStateVersion = "24.11";
      system = "x86_64-linux";
      host = "iron-dell";
      user = "ironche";
    in {
      nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ];
      };

      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home-manager/home.nix ];
        extraSpecialArgs = {
          inherit homeStateVersion;
          inherit user;
          inherit system;
        };
      };
    };
}
