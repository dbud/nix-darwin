{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    skhd
    neovim
    vim
    # vscode
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
    # iina
    yt-dlp

    zsh-history-substring-search

    maple-mono.NF
    alegreya
  ];
}
