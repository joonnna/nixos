{ lib, ... }:

# TODO:
#   - Understand how this nix-module works (where does config and its parameters come from?)
#   - Bind resize mode

{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      keybindings =
        let
          modifier = "Mod1";
        in
        lib.mkOptionDefault {
          # Does not respect $TERMINAL for some reason, suspect the variable
          # is only set for the shell ant not ~/.profile.
          "${modifier}+Return" = "exec alacritty";
          "${modifier}+Shift+l" = "exec i3lock";
          "${modifier}+b" = "exec vivaldi";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
          "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 0.1+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 0.1-";
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

          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+t" = "layout toggle split";
          "${modifier}+h" = "kill";
        };
    };
  };
}
