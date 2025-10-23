{ config, pkgs, ... }:
{
programs = {
    firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          DisableTelemetry = true;
          # add policies here...

          /* ---- EXTENSIONS ---- */
          # to view extension ids: about:debugging#/runtime/this-firefox
          ExtensionSettings = {
            # "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
            # uBlock Origin:
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            # vimium:
            # "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
            #   installation_mode = "force_installed";
            # };
            # add extensions here...
          };


          /* ---- PREFERENCES ---- */
          # Set preferences shared by all profiles.
          Preferences = {
            "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
            "extensions.pocket.enabled" = { Value = "false"; Status = "locked"; };
            "extensions.screenshots.disabled" = { Value = "true"; Status = "locked"; };
            "sidebar.verticalTabs" = { Value = "true"; Status = "locked"; };
            "browser.theme.toolbar-theme" = { Value = "2"; Status = "locked"; };
            "browser.theme.content-theme" = { Value = "2"; Status = "locked"; };
            "extensions.activeThemeID" = { Value = "firefox-compact-dark@mozilla.org"; Status = "locked"; };
            "toolkit.legacyUserProfileCustomizations.stylesheets" = { Value = "true"; Status = "locked"; };


            # add global preferences here...
          };
        };
      };

      /* ---- PROFILES ---- */
      # Switch profiles via about:profiles page.
      # For options that are available in Home-Manager see
      # https://nix-community.github.io/home-manager/options.html#opt-programs.firefox.profiles
      profiles ={
        profile_0 = {           # choose a profile name; directory is /home/<user>/.mozilla/firefox/profile_0
          id = 0;               # 0 is the default profile; see also option "isDefault"
          name = "profile_0";   # name as listed in about:profiles
          isDefault = true;     # can be omitted; true if profile ID is 0
          settings = {          # specify profile-specific preferences here; check about:config for options
            "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
            "browser.startup.homepage" = "https://nixos.org";
            "browser.newtabpage.pinned" = [{
              title = "NixOS";
              url = "https://nixos.org";
            }];
            # add preferences for profile_0 here...
          };
        };
      # add profiles here...
      };
    };
  };
}
