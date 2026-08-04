{
  config,
  pkgs,
  lib,
  ...
}: let
  # Interpolate the nix store path directly into a file:// URI
  wallpaperUri = "file://${../assets/lighthouse.jpg}";
in {
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Ptyxis.desktop"
        "org.gnome.TextEditor.desktop"
      ];
    };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = false;
      color-scheme = "prefer-dark";
      text-scaling-factor = 1.0;
    };
    "org/gnome/desktop/background" = {
      picture-uri = wallpaperUri;
      picture-uri-dark = wallpaperUri;
      picture-options = "zoom";
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 5;
    };

    # Some bullshit
    "org/gnome/settings-daemon/plugins/media-keys" = {
      # Use lib.hm.gvariant.mkArray to explicitly tell dconf this is an array of strings
      custom-keybindings = lib.hm.gvariant.mkArray "s" [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Ptyxis Terminal";
      command = "ptyxis --new-window";
      binding = "<Super>Return";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Firefox Web Browser";
      command = "firefox";
      binding = "<Super>b";
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      switch-to-application-6 = [];
      switch-to-application-7 = [];
      switch-to-application-8 = [];
      switch-to-application-9 = [];
      switch-to-application-10 = [];
    };

    "org/gnome/desktop/wm/keybindings" = {
      # Close window (Super + Q)
      close = ["<Super>q"];

      # Switch to workspaces 1 - 10
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      switch-to-workspace-10 = ["<Super>0"];

      # Move window to workspaces 1 - 10
      move-to-workspace-1 = ["<Super><Shift>1"];
      move-to-workspace-2 = ["<Super><Shift>2"];
      move-to-workspace-3 = ["<Super><Shift>3"];
      move-to-workspace-4 = ["<Super><Shift>4"];
      move-to-workspace-5 = ["<Super><Shift>5"];
      move-to-workspace-6 = ["<Super><Shift>6"];
      move-to-workspace-7 = ["<Super><Shift>7"];
      move-to-workspace-8 = ["<Super><Shift>8"];
      move-to-workspace-9 = ["<Super><Shift>9"];
      move-to-workspace-10 = ["<Super><Shift>0"];
    };
  };
}
