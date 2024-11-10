{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "falcon"; 

  time.timeZone = "Europe/Madrid";
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.yan = {
    home = "/home/yan";
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = ["plugdev" "libvirtd" "docker" "wheel"];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    lm_sensors
    vim
  ];

  services.openssh.enable = true;
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";
  services.smartd.enable = true;

  services.resolved.enable = true;

  networking.firewall.enable = false;
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;

  system.stateVersion = "23.11"; # Did you read the comment?
  system.autoUpgrade = {
    enable = true;
    flake = "github:ravens/nixos-config";
    flags = [ " --no-write-lock-file" ];
    allowReboot = true;
    dates = "02:00";
    rebootWindow = {
      lower = "02:00";
      upper = "05:00";
    };
  };
  nix.optimise.automatic = true;
}
