{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  # using networkmanager for gnome
  networking.networkmanager.enable = true;

  # required by noctalia
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  time.timeZone = "Europe/Stockholm";

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  programs.mango.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    epiphany
    gnome-calendar
    gnome-music
    gnome-maps
  ];

  services.xserver.xkb.layout = "us,se";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  users.users.adam = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.nushell;
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    gnumake
    kitty
    foot
    alacritty
    ptyxis
    swaybg
    libheif # heif-convert
    wmenu
    noctalia
  ];

  environment.shells = [pkgs.nushell];
  security.sudo.wheelNeedsPassword = false;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05";
}
