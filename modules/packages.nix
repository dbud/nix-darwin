{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    skhd
    kitty
    neovim
    vim
    zed-editor
    vscode
    lazygit
    yazi
    direnv

    nodejs_24
    deno
    zig
    rustup

    just
    bat
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
}
