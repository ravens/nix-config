{...}: {
  programs.zsh = {
    enable = true;

    syntaxHighlighting.enable = true;
    enableCompletion = true;

    history.size = 10000;

    shellAliases = {
      ls = "ls --color";
    };

    oh-my-zsh = {
      enable = false;
      theme = "robbyrussell";
      plugins = [
        "git"
        "sudo"
        "kubectl"
        "helm"
        "docker"
        "unixtools.watch"
      ];
    };

    initExtra = ''

      export PATH="$HOME/.krew/bin:$PATH"
      if [[ $(uname -m) == 'arm64' ]]; then
         eval "$(/opt/homebrew/bin/brew shellenv)"
         export PATH="$PATH:/Applications/Wireshark.app/Contents/MacOS"
      fi
      test -e /Users/yan/.iterm2_shell_integration.zsh && source /Users/yan/.iterm2_shell_integration.zsh || true
      alias icat="imgcat"
      alias isvg="rsvg-convert | icat"
      alias idot="dot -Gbgcolor=transparent -Gcolor=transparent -Gbackground=transparent -Ncolor=ghostwhite -Ecolor=ghostwhite -Efontcolor=ghostwhite -Nfontcolor=ghostwhite -Tsvg  | rsvg-convert | icat"
      bindkey -e
    '';
  };
}
