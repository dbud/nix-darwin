{ pkgs, ... }: {
  environment.shellAliases = {
    ls = "ls --color=auto";
    l = "ls -la";
    ".." = "cd ..";
    upflake = "(cd ~/.config/nix-darwin && nix flake update)";
    reflake = "sudo darwin-rebuild switch --flake ~/.config/nix-darwin -v $@";
    "nix-clean" =
      "sudo nix-collect-garbage -d && nix-collect-garbage -d && nix-store --gc";
    nq = "networkQuality";
  };

  environment.variables = {
    PKG_CONFIG_PATH =
      "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.libressl.dev}/lib/pkgconfig";
  };

  environment.systemPath = [ "~/.cargo/bin" ];
}
