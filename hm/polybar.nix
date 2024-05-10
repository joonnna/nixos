{ config, lib, pkgs, ... }:

let
  # background = "#282A2E";
  background = "#09161f";
  # background = "#1f2430";
  background-alt = "#373B41";
  # foreground = "#409FFF4D";
  foreground = "#C5C8C6";
  # primary = "#F0C674";
  # primary = "#2f7358";
  primary = "#FFAD66";
  secondary = "#8ABEB7";
  alert = "#A54242";
  disabled = "#707880";
in
{
  # start polybar on startup
  systemd.user.services.polybar = {
    Install.WantedBy = [ "graphical-session.target" ];
  };

  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
    };
    config = {
      settings = {
        screenchange-reload = true;
      };
      "bar/main" = {
        bottom = true;
        width = "100%";
        height = "20pt";
        background = background;
        foreground = foreground;

        padding-left = 0;
        padding-right = 1;

        font-0 = "Iosevka Nerd Font";
        # font-1 = "fixed:pixelsize=10;1";
        # font-2 = "unifont:fontformat=truetype:size=8:antialias=false;0";
        # font-3 = "Wuncon Siji:pixelsize=10;1";
        font-1 = "EmojiOne:scale=10;2";

        # font-0 = "terminus:pixelsize=10;1";
        # font-1 = "unifont:fontformat=truetype:size=8:antialias=false;0";
        # font-2 = "Siji:pixelsize=10;1";
        # font-3 = "FontAwesome";
        # font-4 = "Symbols Nerd Font:style=Regular";

        # font-0 = "Iosevka Nerd Font Propo,Iosevka NFP Medium:style=Medium,Regular:pixelsize=14;2";
        # font-1 = "Symbols Nerd Font:style=Regular";
        # font-2 = "FontAwesome:style=Regular";
        # font-3 = "Siji:style=Regular:pixelsize=10;1";

        line-size = "3pt";
        border-size = "1pt";
        border-color = "#00000000";

        separator = "|";
        separator-foreground = disabled;

        module-margin = "1";
        modules-left = "i3";
        modules-right = " cpu memory filesystem alsa date";
      };

      "module/date" = {
        type = "internal/date";
        time = "%H:%M";
        label = "%time%";
        label-foreground = primary;
      };

      "module/memory" = {
        type = "internal/memory";
        format-prefix = "RAM";
        format-prefix-foreground = primary;
        label = " %percentage_used:2%%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        # label = "CPU %percentage%%";
        label = "%{F${primary}}CPU%{F-} %percentage%%";
      };

      "module/filesystem" = {
        type = "internal/fs";
        interval = 25;
        label-mounted = "%{F${primary}}DISK%{F-} %percentage_used%%";
        # label-mounted = "DISK %percentage_used%%";
        label-unmounted = "%mountpoint% not mounted";
        label-unmounted-foreground = disabled;
      };

      "module/alsa" = {
        type = "internal/alsa";
        label-muted = "🔇 muted";
        label-muted-foreground = "#66";

        # label-volume = "VOL %percentage%%";
        label-volume = "%{F${primary}}VOL%{F-} %percentage%%";
        # format-volume = "<ramp-volume> <label-volume>";

        # ramp-volume-0 = "🔈";
        # ramp-volume-1 = "🔉";
        # ramp-volume-2 = "🔊";

        # ramp-headphones-0 = "🎧";
        # ramp-headphones-1 = "🎧";
      };

      # "module/system-bluetooth-bluetoothctl" = {
      #   type = "custom/script";
      #   exec = "~/test.sh";
      #   tail = "true";
      #   click-left = "~/test.sh --toggle &";
      # };

      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = true;
        show-urgent = true;
        # index-sort = true;
        # label-separator = "|";
        # ws-icon-0 = "10;0";
        # label-separator-padding = 1;
        # label-separator-foreground = "#ffb52a";
        # label-separator-foreground = foreground;

        # label-focused-foreground = "#ffffff";
        # label-focused-background = "#428bca";
        # label-focused-underline = "#fba922";
        # label-focused-padding = "1";


        format = "<label-state>";
        label-focused-background = background-alt;
        # label-focused-underline = primary;
        label-focused = "%name%";
        label-focused-padding = 1;

        label-unfocused = "%name%";
        label-unfocused-padding = 1;

        label-visible = "%name%";
        label-visible-padding = 1;

        label-mode = "%name%";
        label-mode-padding = 1;

        label-urgent = "%name%";
        label-urgent-background = alert;
        label-urgent-padding = 1;
      };

      # "module/wired-network" = {
      #   type = "internal/network";
      #   interface = "enp4s0";
      #   interval = "3.0";
      #   speed-unit = "Mbit/s";
      #   label-connected = "%local_ip%";
      #   label-connected-foreground = "#eefafa";
      # };


      # "module/date" = {
      #   type = "internal/date";
      #   internal = 5;
      #   date = "%Y-%m-%d";
      #   time = "%H:%M";
      #   label = "%date% %time%";
      # };
      # "module/i3" = {
      #   type = "internal/i3";
      #   scroll-up = "i3wm-wsnext";
      #   scroll-down = "i3wm-wsprev";
      # };
    };

    script = ''
      killall -q polybar

      # Wait until the processes have been shut down
      while pgrep -x polybar >/dev/null; do sleep 1; done

      # Launch polybar
      polybar main &
    '';
  };
}
