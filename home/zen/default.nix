{ inputs
, pkgs
, lib
, ...
}:
let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  prefs = {
    # Check these out at about:config
    "extensions.autoDisableScopes" = 0;
    "extensions.pocket.enabled" = false;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  };

  extensions = [
    # To add additional extensions, find it on addons.mozilla.org, find
    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
    (extension "myepitechpercentage" "@myepitechpercentage.reyshyram")
    (extension "plasma-integration" "plasma-browser-integration@kde.org")
    (extension "proton-vpn-firefox-extension" "vpn@proton.ch")
    (extension "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
    (extension "betterttv" "firefox@betterttv.net")
    # ...
  ];

  zenFlavor = "Latte"; # Latte | Frappe | Macchiato | Mocha
  zenAccent = "Yellow"; # check exact casing in the repo's themes/<flavor>/ folder
  catppuccinZen = inputs.catppuccin-zen;
  zenThemeDir = "${catppuccinZen}/themes/${zenFlavor}/${zenAccent}";
  zenFlavorLower = lib.toLower zenFlavor;

in
{
  home.packages = [
    (pkgs.wrapFirefox
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
      {
        extraPrefs = lib.concatLines (
          lib.mapAttrsToList
            (
              name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
            )
            prefs
        );

        extraPolicies = {
          DisableTelemetry = true;
          ExtensionSettings = builtins.listToAttrs extensions;

          SearchEngines = {
            Default = "ddg";
            Add = [
              {
                Name = "nixpkgs packages";
                URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@np";
              }
              {
                Name = "NixOS options";
                URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@no";
              }
              {
                Name = "NixOS Wiki";
                URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@nw";
              }
              {
                Name = "noogle";
                URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                IconURL = "https://noogle.dev/favicon.ico";
                Alias = "@ng";
              }
            ];
          };
        };
      }
    )
  ];
  home.activation.zenCatppuccinTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    for profile in "$HOME"/.config/zen/*/; do
      [ -d "$profile" ] || continue
      mkdir -p "$profile/chrome"
      ln -sf "${zenThemeDir}/userChrome.css" "$profile/chrome/userChrome.css"
      ln -sf "${zenThemeDir}/userContent.css" "$profile/chrome/userContent.css"
      ln -sf "${zenThemeDir}/zen-logo-${zenFlavorLower}.svg" "$profile/chrome/zen-logo-${zenFlavorLower}.svg"
    done
  '';
}
