{
  description = "nix flake configuration for my hosts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-24.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixvim,
    ...
  }: let
    nixpkgsConfig = {
      config.allowUnfree = true;
      # config.allowBroken = true;
    };
  in {
    nixosConfigurations = let
      inherit (inputs.nixpkgs.lib) nixosSystem;
      inherit (inputs.home-manager.nixosModules) home-manager;
      in {
        falcon = nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/falcon/configuration.nix
            home-manager
            {
              nixpkgs = nixpkgsConfig;

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                nixvim.homeManagerModules.nixvim
              ];
              home-manager.users.yan = import ./home/home.nix;
            }
          ];
        };
      };
  };
}