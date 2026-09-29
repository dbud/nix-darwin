{ ... }:
{
  # Publishes the Home Manager profile, including its hm-session-vars.sh, into
  # the system profile, which is where modules/home/zshrc sources it from.
  home-manager.useUserPackages = true;

  # Move an existing dotfile aside instead of failing the first activation.
  home-manager.backupFileExtension = "backup";

  home-manager.users.dbud =
    { ... }:
    {
      home.stateVersion = "26.05";

      # Prepended to PATH by modules/home/zshrc. Android paths are spelled out
      # rather than derived from ANDROID_HOME because session variables are not
      # guaranteed to be set in a usable order.
      home.sessionVariables.ANDROID_HOME = "$HOME/Library/Android/sdk";
      home.sessionPath = [
        "$HOME/.local/bin"
        "$HOME/.cargo/bin"
        "$HOME/Library/Python/3.14/bin"
        "$HOME/Library/Android/sdk/emulator"
        "$HOME/Library/Android/sdk/platform-tools"
      ];

      home.file = {
        ".zshrc".source = ./home/zshrc;
        ".config/ghostty/config".source = ./home/ghostty-config;
      };
    };
}
