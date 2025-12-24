{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    skhd
    # kitty
    rio
    neovim
    vim
    # zed-editor # slow updates
    vscode
    lazygit
    yazi
    direnv
    fd

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
    tree
    htop
    gnupg
    gh
    hyperfine
    dust
    lsd
    duf
    ripgrep
    # libressl
    nvd
    nil
    nixd
    nixfmt-classic

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
