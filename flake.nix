{
  description = "dbud-mba nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";

    dtomvan-nixpkgs.url = "github:dtomvan/nixpkgs/dtomvan/push-zypzvrwlmlrm";
  };

  outputs =
    { self, nix-darwin, nix-homebrew, mac-app-util, dtomvan-nixpkgs, ... }:
    let
      system = "aarch64-darwin";

      overlay-telegram-desktop = final: prev: {
        telegram-desktop = (import dtomvan-nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }).telegram-desktop;
      };

      pkgs = import nix-darwin.inputs.nixpkgs {
        system = "aarch64-darwin";
        overlays = [ overlay-telegram-desktop ];
        config.allowUnfree = true;
      };
    in {
      darwinConfigurations."dima-mba" = nix-darwin.lib.darwinSystem {
        inherit pkgs;
        modules = [
          ({ pkgs, ... }: import ./configuration.nix { inherit self pkgs; })
          nix-homebrew.darwinModules.nix-homebrew
          mac-app-util.darwinModules.default
        ];
      };
    };
}
