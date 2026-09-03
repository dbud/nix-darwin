{
  homebrew = {
    enable = true;
    brews = [
      "mas"
      "displayplacer"
      "jandedobbeleer/oh-my-posh/oh-my-posh"
      "elixir"
      "node"
      "apfel"
      "deno"
    ];
    taps = [
      "jandedobbeleer/oh-my-posh"
    ];
    casks = [
      "chatgpt"
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
      # "wolfram-engine"
      # "wljs-notebook"
      "firefox"
      "google-chrome"
      "font-zed-mono-nerd-font"
      "font-maple-mono-nf"
      "rio"
      "android-studio"
      "spotify"
      "basictex"
      "gitup-app"
      "thaw@beta"
      "lulu"
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
