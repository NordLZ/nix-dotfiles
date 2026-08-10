{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Enable Limine
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix-laptop";

  # Configure network connections interactively with nmcli or nmtui.
  networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  # noctalia
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    #autoRepeatInterval = 35;
    autoRepeatInterval = 60;
  };

  services.displayManager.gdm.enable = true;

  services.desktopManager.gnome.enable = true;

  programs.mango.enable = true;

  # TODO: maybe move to gnome module
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
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adam = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    shell = pkgs.nushell;
  };

  programs.firefox.enable = true;

  # You can use https://search.nixos.org/ to find more packages (and options).
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
