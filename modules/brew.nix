{
  homebrew = {
    enable = true;
    brews = [
      "mas"
      "displayplacer"
      "jandedobbeleer/oh-my-posh/oh-my-posh"
      "elixir"
      "node"
    ];
    taps = [ "jandedobbeleer/oh-my-posh" "jank-lang/jank" ];
    masApps = {
      "AdGuard for Safari" = 1440147259;
      "Amphetamine" = 937984704;
      "Pixelmator Pro" = 1289583905;
      "HacKit" = 1549557075;
      "Consent-O-Matic" = 1606897889;
      "Vimkey" = 1585682577;
      "WhatsApp Messenger" = 310633997;
      # "Spark" = 6445813049;
      # "Xcode" = 497799835;
      # "Organic Maps: GPS navigation" = 1567437057;
    };
    casks = [
      "chatgpt"
      "readdle-spark"
      "karabiner-elements"
      "displaperture"
      "font-iosevka-ss05"
      "ilya-birman-typography-layout"
      "telegram"
      "messenger"
      "stats"
      "steam"
      "fliqlo"
      "raycast"
      "jordanbaird-ice"
      "lunar"
      # "ghostty"
      # "wolfram-engine"
      # "wljs-notebook"
      "firefox"
      "font-zed-mono-nerd-font"
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
