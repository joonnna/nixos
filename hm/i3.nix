{ lib, ... }:

# # TODO:
# #   - Understand how this nix-module works (where does config and its parameters come from?)
# #   - Bind resize mode

{
  xsession.windowManager.i3 = {
    enable = true;

    # extraConfig = ''
    #   default_border pixel 8
    #   default_floating_border pixel 8
    # '';
    #
    #
    config = {
      # removes all bars (default i3 bar)
      # bars = [ ];
      colors.focused = {
        background = "#285577";
        border = "#4c7899";
        childBorder = "#285577";
        indicator = "#2e9ef4";
        text = "#ffffff";
      };

      keybindings =
        let
          modifier = "Mod1";
        in
        lib.mkOptionDefault {
          # Does not respect $TERMINAL for some reason, suspect the variable
          # is only set for the shell ant not ~/.profile.
          "${modifier}+t" = "exec alacritty";
          "${modifier}+p" = "exec 1password";
          "${modifier}+Shift+l" = "exec i3lock";
          "${modifier}+v" = "exec vivaldi";
          "${modifier}+r" = "exec rofi -show drun";
          "${modifier}+d" = "exec dbeaver";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 0.05+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 0.05-";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioPause" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86MonBrightnessDown" = "exec brightnessctl s 5%-";
          "XF86MonBrightnessUp" = "exec brightnessctl s +5%";
          "${modifier}+n" = "focus left";
          "${modifier}+e" = "focus down";
          "${modifier}+i" = "focus up";
          "${modifier}+o" = "focus right";

          "${modifier}+Shift+n" = "move left";
          "${modifier}+Shift+e" = "move down";
          "${modifier}+Shift+i" = "move up";
          "${modifier}+Shift+o" = "move right";

          "${modifier}+m" = "fullscreen";
          "${modifier}+l" = "layout stacking";
          "${modifier}+u" = "layout tabbed";
          "${modifier}+y" = "layout toggle split";
          "${modifier}+h" = "kill";
          "${modifier}+Shift+r" = "reload";
        };
    };
  };
}
