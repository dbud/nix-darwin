{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    skhd
    rio
    neovim
    vim
    # zed-editor # slow updates
    vscode
    lazygit
    yazi
    direnv
    fd
    gettext
    xdg-utils

    # nodejs_24 # use brew
    opam
    deno
    zig
    rustup

    just
    pkg-config
    openssl
    fzf
    cmake
    ninja
    tree
    htop
    gnupg
    gh
    hyperfine
    dust
    lsd
    duf
    ripgrep
    nvd
    nil
    nixd
    nixfmt

    # firefox # use brew
    ffmpeg
    iina
    yt-dlp
    # qbittorrent
    # telegram-desktop
    # totp-cli

    zsh-history-substring-search

    amfora
    lagrange
  ];

  # fonts.packages = [ pkgs.nerd-fonts.zed-mono ];
}
