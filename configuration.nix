{ self, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    skhd
    kitty
    neovim
    vim
    zed-editor
    vscode
    lazygit
    yazi

    nodejs_24
    deno
    zig
    rustup

    just
    pkg-config
    openssl
    fzf
    cmake
    tree
    htop
    gnupg
    gh
    hyperfine
    ripgrep
    libressl
    nvd
    nil
    nixd
    nixfmt-classic

    firefox
    ffmpeg
    iina
    yt-dlp
    qbittorrent
    telegram-desktop
    totp-cli

    zsh-history-substring-search

    offpunk
    amfora
    lagrange
  ];

  fonts.packages = [ pkgs.nerd-fonts.zed-mono ];

  homebrew = {
    enable = true;
    brews = [ "mas" "displayplacer" "jandedobbeleer/oh-my-posh/oh-my-posh" ];
    taps = [ "jandedobbeleer/oh-my-posh" ];
    masApps = {
      "AdGuard for Safari" = 1440147259;
      "Amphetamine" = 937984704;
      "Pixelmator Pro" = 1289583905;
      "HacKit" = 1549557075;
      "Consent-O-Matic" = 1606897889;
      "Vimkey" = 1585682577;
      "WhatsApp Messenger" = 310633997;
      # "Xcode" = 497799835;
    };
    casks = [
      "chatgpt"
      "readdle-spark"
      "karabiner-elements"
      "displaperture"
      "font-iosevka-ss05"
      "ilya-birman-typography-layout"
      # "telegram"
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

  services.yabai = {
    enable = true;
    config = {
      layout = "bsp";
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;
    };
  };

  services.skhd = {
    enable = true;
    skhdConfig =
      builtins.replaceStrings [ "rhyper" ] [ "rcmd + rctrl + ralt + rshift" ] ''
        rhyper - z : open -a /Applications/Nix\ Apps/Zed.app
        rhyper - k : open -a /Applications/Nix\ Apps/kitty.app
        rhyper - e : open -a /Applications/Nix\ Apps/Telegram.app
        rhyper - t : open -a /Applications/Telegram.app
        rhyper - w : open -a /Applications/WhatsApp.app
        rhyper - s : open -a /Applications/Safari.app
        rhyper - l : open -a /Applications/Logic\ Pro.app
        rhyper - d : open -a /Applications/Dorico\ 5.app
        rhyper - m : open -a /System/Applications/Music.app
        rhyper - f : open -a /Applications/Firefox.app
        rhyper - h : open -a /Applications/HacKit.app
        rhyper - c : open -a /Applications/Nix\ Apps/Visual\ Studio\ Code.app
        rhyper - i : open -a /Applications/Nix\ Apps/IINA.app
        rhyper - p : open -a /Applications/Pixelmator\ Pro.app

        rhyper - 1 : issw org.sil.ukelele.keyboardlayout.t.english–ilyabirmantypography
        rhyper - 2 : issw org.sil.ukelele.keyboardlayout.t.russian–ilyabirmantypography

        # hyper - +
        rhyper - 0x1B : $(brew --prefix)/bin/displayplacer "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:2560x1664 hz:60 color_depth:8 enabled:true scaling:off origin:(0,0) degree:0"
        rhyper - 0x18 : $(brew --prefix)/bin/displayplacer "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1710x1112 hz:60 color_depth:8 enabled:true scaling:on origin:(0,0) degree:0"

        # hyper |
        rhyper - 0x2A : osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'

        # focus window
        ctrl + alt - left : yabai -m window --focus west
        ctrl + alt - right : yabai -m window --focus east
        ctrl + alt - down : yabai -m window --focus south
        ctrl + alt - up : yabai -m window --focus north

        # move window
        ctrl + alt + shift - left : yabai -m window --warp west
        ctrl + alt + shift - down : yabai -m window --warp south
        ctrl + alt + shift - up : yabai -m window --warp north
        ctrl + alt + shift - right : yabai -m window --warp east

        # swap window
        # shift + alt - left : yabai -m window --swap west
        # shift + alt - down : yabai -m window --swap south
        # shift + alt - up : yabai -m window --swap north
        # shift + alt - right : yabai -m window --swap east
      '';
  };

  system.primaryUser = "dbud";

  system.defaults = {
    dock.autohide = true;
    WindowManager.StandardHideDesktopIcons = true;
  };

  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    promptInit = ''
      if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
        eval "$(oh-my-posh init zsh --config ~/.config/dbud.omp.toml)"
      fi
    '';
    interactiveShellInit =
      "source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh";
    shellInit = ''
      function y() {
      	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
      	yazi "$@" --cwd-file="$tmp"
      	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      		builtin cd -- "$cwd"
      	fi
      	rm -f -- "$tmp"
      }
    '';
  };

  environment.shellAliases = {
    ls = "ls --color=auto";
    l = "ls -la";
    ".." = "cd ..";
    "upflake" = "(cd ~/.config/nix-darwin && nix flake update)";
    "reflake" = "sudo darwin-rebuild switch --flake ~/.config/nix-darwin -v $@";
    "nix-clean" =
      "sudo nix-collect-garbage -d && nix-collect-garbage -d && nix-store --gc";
    "z" = "zeditor";
  };

  environment.variables = {
    PKG_CONFIG_PATH =
      "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.libressl.dev}/lib/pkgconfig";
  };

  environment.systemPath = [ "~/.cargo/bin" ];

  security.pam.services.sudo_local.touchIdAuth = true;

  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
