{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    profiles.adam = {
      settings = {
        "privacy.trackingprotection.enabled" = true;
      };
    };
  };
}
