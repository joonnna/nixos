{ lib, config, pkgs, ... }:

# https://discourse.nixos.org/t/help-setting-up-firefox-with-home-manager/23333
# https://nix-community.github.io/home-manager/options.html#opt-programs.firefox.profiles._name_.bookmarks
{

  # nixpkgs.config.packageOverrides = pkgs: {
  #   nur = import
  #     (builtins.fetchTarball {
  #       # Get the revision by choosing a version from https://github.com/nix-community/NUR/commits/master
  #       url = "https://github.com/nix-community/NUR/archive/3a6a6f4da737da41e27922ce2cfacf68a109ebce.tar.gz";
  #       # Get the hash by running `nix-prefetch-url --unpack <url>` on the above url
  #       sha256 = "04387gzgl8y555b3lkz9aiw9xsldfg4zmzp930m62qw8zbrvrshd";
  #     })
  #     {
  #       inherit pkgs;
  #     };
  # };

  # imports = [ pkgs.nur.repos.rycee.firefox-addons ];

  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        # CaptivePortal = false;
        # DisableFirefoxStudies = true;
        # DisablePocket = true;
        # DisableTelemetry = true;
        # DisableFirefoxAccounts = false;
        # NoDefaultBookmarks = true;
        # OfferToSaveLogins = false;
        # OfferToSaveLoginsDefault = false;
        # PasswordManagerEnabled = false;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };
    };
    profiles = {
      jon = {
        id = 0;
        name = "jon";
        search = {
          force = true;
          default = "Google";
          engines = {
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            # "NixOS Wiki" = {
            #   urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            #   iconUpdateURL = "https://nixos.wiki/favicon.png";
            #   updateInterval = 24 * 60 * 60 * 1000;
            #   definedAliases = [ "@nw" ];
            # };

            "Wikipedia (en)".metaData.alias = "@wiki";
            "Google".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "Bing".metaData.hidden = true;
            "eBay".metaData.hidden = true;
          };
        };

        # settings = {
        #   # "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        #   # "browser.startup.homepage" = "https://google.com";
        # };

        userChrome = ''
          @-moz-document url(chrome://browser/content/browser.xhtml) {
          	/* tabs on bottom of window */
          	/* requires that you set
          	 * toolkit.legacyUserProfileCustomizations.stylesheets = true
          	 * in about:config
          	 */
          	#main-window body { flex-direction: column-reverse !important; }
          	#navigator-toolbox { flex-direction: column-reverse !important; }
          	#urlbar {
          		top: unset !important;
          		bottom: calc((var(--urlbar-toolbar-height) - var(--urlbar-height)) / 2) !important;
          		box-shadow: none !important;
          		display: flex !important;
          		flex-direction: column !important;
          	}
          	#urlbar-input-container {
          		order: 2;
          	}
          	#urlbar > .urlbarView {
          		order: 1;
          		border-bottom: 1px solid #666;
          	}
          	#urlbar-results {
          		display: flex;
          		flex-direction: column-reverse;
          	}
          	.search-one-offs { display: none !important; }
          	.tab-background { border-top: none !important; }
          	#navigator-toolbox::after { border: none; }
          	#TabsToolbar .tabbrowser-arrowscrollbox,
          	#tabbrowser-tabs, .tab-stack { min-height: 28px !important; }
          	.tabbrowser-tab { font-size: 80%; }
          	.tab-content { padding: 0 5px; }
          	.tab-close-button .toolbarbutton-icon { width: 12px !important; height: 12px !important; }
          	toolbox[inFullscreen=true] { display: none; }
          	/*
          	 * the following makes it so that the on-click panels in the nav-bar
          	 * extend upwards, not downwards. some of them are in the #mainPopupSet
          	 * (hamburger + unified extensions), and the rest are in
          	 * #navigator-toolbox. They all end up with an incorrectly-measured
          	 * max-height (based on the distance to the _bottom_ of the screen), so
          	 * we correct that. The ones in #navigator-toolbox then adjust their
          	 * positioning automatically, so we can just set max-height. The ones
          	 * in #mainPopupSet do _not_, and so we need to give them a
          	 * negative margin-top to offset them *and* a fixed height so their
          	 * bottoms align with the nav-bar. We also calc to ensure they don't
          	 * end up overlapping with the nav-bar itself. The last bit around
          	 * cui-widget-panelview is needed because "new"-style panels (those
          	 * using "unified" panels) don't get flex by default, which results in
          	 * them being the wrong height.
          	 *
          	 * Oh, yeah, and the popup-notification-panel (like biometrics prompts)
          	 * of course follows different rules again, and needs its own special
          	 * rule.
          	 */
          	#mainPopupSet panel.panel-no-padding { margin-top: calc(-50vh + 40px) !important; }
          	#mainPopupSet .panel-viewstack, #mainPopupSet popupnotification { max-height: 50vh !important; height: 50vh; }
          	#mainPopupSet panel.panel-no-padding.popup-notification-panel { margin-top: calc(-50vh - 35px) !important; }
          	#navigator-toolbox .panel-viewstack { max-height: 75vh !important; }
          	panelview.cui-widget-panelview { flex: 1; }
          	panelview.cui-widget-panelview > vbox { flex: 1; min-height: 50vh; }
          }
        '';

        # "general.smoothScroll" = true;
        # settings = {
        # };

        #   user_pref("full-screen-api.ignore-widgets", true);
        #   user_pref("media.ffmpeg.vaapi.enabled", true);
        #   user_pref("media.rdd-vpx.enabled", true);
        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        '';
      };
    };
  };
}


