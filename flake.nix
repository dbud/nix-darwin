{
  description = "dbud-mba nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    {
      self,
      nix-darwin,
      nix-homebrew,
      mac-app-util,
      ...
    }:
    {
      darwinConfigurations."dima-mba" = nix-darwin.lib.darwinSystem {
        modules = [
          ({ pkgs, ... }: import ./configuration.nix { inherit self pkgs; })
          nix-homebrew.darwinModules.nix-homebrew
          mac-app-util.darwinModules.default
        ];
      };
    };
}
