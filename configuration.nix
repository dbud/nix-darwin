{ self, home-manager, ... }:
{
  imports = [
    ./modules/packages.nix
    ./modules/brew.nix
    ./modules/services/yabai.nix
    ./modules/services/skhd.nix
    ./modules/services/jankyborders.nix
    ./modules/programs/zsh.nix
    ./modules/environment.nix
    ./modules/system.nix
    ./modules/home.nix
    home-manager.darwinModules.home-manager
  ];

  system.primaryUser = "dbud";

  # Home Manager reads the name and home directory of the account it manages
  # from here. nix-darwin will not create the user, because that only happens
  # for names listed in users.knownUsers.
  users.users.dbud = {
    name = "dbud";
    home = "/Users/dbud";
  };

  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
}
