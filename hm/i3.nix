{ config, lib, pkgs, ... }:


{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod1";
      keybindings =
        let modifier = "Mod1";
        in
        lib.mkOptionDefault {
          # Does not respect $TERMINAL for some reason, suspect the variable
          # is only set for the shell ant not ~/.profile.
          "${modifier}+Return" = "exec alacritty";
          # "${modifier}+Shift+i" = "exec i3lock";
          "${modifier}+Shift+d" = "exec wpctl set-volume @DEFAULT_SINK@ 0.1-";
          "${modifier}+Shift+l" = "exec wpctl set-volume @DEFAULT_SINK@ 0.1+";
          "${modifier}+n" = "focus left";
          "${modifier}+e" = "focus down";
          "${modifier}+i" = "focus up";
          "${modifier}+o" = "focus right";
        };
    };
  };
}
