{pkgs, ...}: {
  home.stateVersion = "23.11";

  imports = [
    ./zsh.nix
    ./starship.nix
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    htop
    jq
    kubectl
    docker
    k9s
    graphviz
    go
    fluxcd
    kustomize
    clang
    cmake
    gnumake
    unzip
    file
    neofetch
    mtr
    kubernetes-helm
    iperf
    ansible
    deadnix
    colima
    kind
    clusterctl
    kubectx
    cilium-cli
    wget
    krew
    speedtest-go
    hubble
    nmap
    stern
  ];

  programs.yt-dlp.enable = true;

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {enable = true;};
  programs.git.enable = true;
  programs.home-manager.enable = true;
}
