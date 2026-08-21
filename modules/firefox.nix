{pkgs, ...}: {
  programs.firefox = {
    enable = true;

    # Enterprise Policies: applied globally across all profiles and locked against browser tamers.
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxAccounts = false; # Set to true if you do not use Firefox Sync
      DisableAccounts = false;
      DisableFirefoxScreenshots = false;
      OverrideFirstRunPage = "";
      # OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;

      # Built-in privacy protections
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      # UI Debloat & Suggestions
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        UrlbarInterventions = false;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsorSuggestions = false;
        ImproveSuggest = false;
      };
      AIControls = {
        Default = "blocked";
      };
      GenerativeAI = {
        Enabled = false;
      };

      # Declarative Extension Management via AMO downloads
      ExtensionSettings = {
        "*" = {
          installation_mode = "blocked"; # Prevents unauthorized extensions from being installed
        };
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";

          installation_mode = "force_installed";
        };
        # # Bitwarden (optional example)
        # "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        #   installation_mode = "force_installed";
        # };
      };
    };

    # Profile Configuration
    profiles.default = {
      id = 0;
      isDefault = true;
      name = "default";

      settings = {
        # Privacy & Security Hardening
        "privacy.donottrackheader.enabled" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "dom.security.https_only_mode" = false;
        "network.cookie.cookieBehavior" = 1; # Reject third-party cookies

        # Telemetry & Beacon removal
        "beacon.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;

        # Disable Firefox sponsored content & new tab clutter
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

        "browser.contextual-password-manager.enabled" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.translations.neverTranslateLanguages" = "sv,de";
        "browser.aboutConfig.showWarning" = false;
        "sidebar.verticalTabs" = true;
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
        "sidebar.expandOnHover" = true;
      };
      search.engines = {
        nix-packages = {
          name = "Nix Packages";
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@np"];
        };

        nix-options = {
          name = "Nix Options";
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@no"];
        };
      };
    };
  };
}
