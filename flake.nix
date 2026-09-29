{
  description = "dbud-mba nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nix-darwin,
      nix-homebrew,
      home-manager,
      ...
    }:
    {
      darwinConfigurations."dima-mba" = nix-darwin.lib.darwinSystem {
        modules = [
          (
            { pkgs, ... }:
            import ./configuration.nix {
              inherit self pkgs home-manager;
            }
          )
          nix-homebrew.darwinModules.nix-homebrew
        ];
      };
    };
}
