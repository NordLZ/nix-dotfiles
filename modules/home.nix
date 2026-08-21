{pkgs, ...}: {
  home.username = "adam";
  home.homeDirectory = "/home/adam";
  home.stateVersion = "26.05";

  imports = [
    ./dotfiles.nix
    ./nushell.nix
    ./gnome.nix
    ./neovim.nix
    ./firefox.nix
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Adam Nord";
        email = "adam.nord04@gmail.com";
      };
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  programs.bash = {
    enable = true;
  };

  # Set default applications (MIME types)
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Default Web Browser
      "text/html" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "x-scheme-handler/about" = ["firefox.desktop"];
      "x-scheme-handler/unknown" = ["firefox.desktop"];

      # Default PDF Viewer
      "application/pdf" = ["firefox.desktop"];

      # Default Media Player (Videos & Audio)
      "video/mp4" = ["mpv.desktop"];
      "video/mkv" = ["mpv.desktop"];
      "video/webm" = ["mpv.desktop"];
      "video/avi" = ["mpv.desktop"];
      "audio/mpeg" = ["mpv.desktop"];
      "audio/flac" = ["mpv.desktop"];
      "audio/ogg" = ["mpv.desktop"];
      "audio/wav" = ["mpv.desktop"];
    };
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # General GUI & CLI tools
  home.packages = with pkgs; [
    # GUI
    mpv
    tor-browser
    anki
    spotify
    vscodium
    obsidian
    wmenu
    ghostty
    qbittorrent
    zed-editor
    calibre
    czkawka
    libreoffice

    tree
    tldr
    fd
    lazygit
    libheif # for heif-convert
    rust-analyzer
    btop
    fastfetch
    bitwarden-cli
  ];
}
