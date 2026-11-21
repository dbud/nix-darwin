{
  homebrew = {
    enable = true;
    brews = [
      "mas"
      "displayplacer"
      "elixir"
      "node"
    ];
    taps = [ ];
    casks = [
      "readdle-spark"
      "karabiner-elements"
      "displaperture"
      "font-iosevka-ss05"
      "ilya-birman-typography-layout"
      "telegram"
      "stats"
      "steam"
      "fliqlo"
      "raycast"
      "ghostty"
      "firefox"
      "google-chrome"
      "font-zed-mono-nerd-font"
      "font-maple-mono-nf"
      "android-studio"
      "spotify"
      "basictex"
      "thaw@beta"
      "lulu"
      "linear"
      "claude-code"
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "dbud";
  };
}
