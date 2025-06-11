{ self, ... }: {
  imports = [
    ./modules/packages.nix
    ./modules/brew.nix
    ./modules/services/yabai.nix
    ./modules/services/skhd.nix
    ./modules/programs/zsh.nix
    ./modules/environment.nix
    ./modules/system.nix
  ];

  system.primaryUser = "dbud";
  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
}
