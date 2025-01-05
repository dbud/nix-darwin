{
  description = "dbud-mba nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nix-homebrew, nixpkgs, mac-app-util }:
    let
      configuration = { pkgs, ... }: {
        nixpkgs.config.allowUnfree = true;

        environment.systemPackages = [
          pkgs.vim
          pkgs.zed-editor
          pkgs.nil
          pkgs.nixd
          pkgs.nixfmt-classic
          pkgs.iterm2
          # pkgs.karabiner-elements
          pkgs.skhd
          pkgs.ffmpeg
          pkgs.gh
          pkgs.bartender
          # pkgs.telegram-desktop
          pkgs.whatsapp-for-mac
          pkgs.iina
          pkgs.yt-dlp
          pkgs.rustup
          pkgs.deno
          pkgs.tree
          pkgs.cmake
          pkgs.gnupg
          pkgs.qbittorrent
        ];

        fonts.packages = [ pkgs.nerd-fonts.zed-mono ];

        homebrew = {
          enable = true;
          brews =
            [ "mas" "displayplacer" "jandedobbeleer/oh-my-posh/oh-my-posh" ];
          taps = [ "jandedobbeleer/oh-my-posh" ];
          masApps = {
            "AdGuard for Safari" = 1440147259;
            "Amphetamine" = 937984704;
            "Pixelmator Pro" = 1289583905;
          };
          casks = [
            "chatgpt"
            "alfred"
            "readdle-spark"
            "karabiner-elements"
            "displaperture"
            "font-iosevka-ss05"
            "ilya-birman-typography-layout"
            "telegram"
            "messenger"
            "firefox"
          ];
          onActivation = {
            cleanup = "zap";
            autoUpdate = true;
            upgrade = true;
          };
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
          skhdConfig = builtins.replaceStrings [ "rhyper" ]
            [ "rcmd + rctrl + ralt + rshift" ] ''
              rhyper - z : open -a /Applications/Nix\ Apps/Zed.app
              rhyper - t : open -a /Applications/Nix\ Apps/iTerm2.app
              rhyper - e : open -a /Applications/Telegram.app
              rhyper - w : open -a /Applications/Nix\ Apps/WhatsApp.app
              rhyper - s : open -a /Applications/Safari.app
              rhyper - l : open -a /Applications/Logic\ Pro.app
              rhyper - d : open -a /Applications/Dorico\ 5.app
              rhyper - m : open -a /Applications/Spark\ Desktop.app
              rhyper - f : open -a /Applications/Firefox.app

              rhyper - 1 : issw org.sil.ukelele.keyboardlayout.t.english–ilyabirmantypography
              rhyper - 2 : issw org.sil.ukelele.keyboardlayout.t.russian–ilyabirmantypography

              # hyper - +
              rhyper - 0x1B : $(brew --prefix)/bin/displayplacer "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:2560x1664 hz:60 color_depth:8 enabled:true scaling:off origin:(0,0) degree:0"
              rhyper - 0x18 : $(brew --prefix)/bin/displayplacer "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1710x1112 hz:60 color_depth:8 enabled:true scaling:on origin:(0,0) degree:0"

              # hyper /
              rhyper - 0x2C : osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'

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
        };

        environment.shellAliases = {
          ls = "ls --color=auto";
          l = "ls -la";
          ".." = "cd ..";
        };

        security.pam.enableSudoTouchIdAuth = true;

        services.nix-daemon.enable = true;
        nix.settings.experimental-features = "nix-command flakes";
        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 5;
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in {
      darwinConfigurations."dima-mba" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "dbud";
            };
          }
          mac-app-util.darwinModules.default
        ];
      };
    };
}
