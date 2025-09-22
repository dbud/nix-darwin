{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    promptInit = ''
      if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
        export PATH="/opt/homebrew/bin:$PATH"
        eval "$(oh-my-posh init zsh --config ~/.config/dbud.omp.toml)"
      fi
      eval "$(direnv hook zsh)"
      if [ "$PWD" = "/" ]; then
        cd "$HOME"
      fi
    '';
    interactiveShellInit =
      "source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh";
    shellInit = builtins.readFile ./shell-init.sh;
  };
}
