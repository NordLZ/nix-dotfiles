{pkgs, ...}: {
  home.packages = with pkgs; [
    playerctl # needed for song changes
  ];
}
