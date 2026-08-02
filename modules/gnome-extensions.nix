{pkgs, ...}: {
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-panel
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "dash-to-panel@jderose9.github.com"
      ];
    };
  };
}
