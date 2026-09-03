{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    skhd
    neovim
    vim
    lazygit
    yazi
    fd
    gettext
    xdg-utils

    opam
    zig
    rustup
    python314
    python3Packages.pip
    go

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
    timg

    ffmpeg
    yt-dlp

    zsh-history-substring-search

    maple-mono.NF
    alegreya
  ];
}
