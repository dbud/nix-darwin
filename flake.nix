{
  description = "dbud-mba nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    {
      self,
      nix-darwin,
      nix-homebrew,
      ...
    }:
    {
      darwinConfigurations."dima-mba" = nix-darwin.lib.darwinSystem {
        modules = [
          ({ pkgs, ... }: import ./configuration.nix { inherit self pkgs; })
          nix-homebrew.darwinModules.nix-homebrew
        ];
      };
    };
}
