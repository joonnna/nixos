{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # exec-once = "eww daemon";
      "$mod" = "ALT";
      "general:no_border_on_floating" = true;
      "decoration:rounding" = 20;
      binde = [
        "$mod ctrl, n, resizeactive, -20 0"
        "$mod ctrl, e, resizeactive, 0 20"
        "$mod ctrl, i, resizeactive, 0 -20"
        "$mod ctrl, o, resizeactive, 20 0"
      ];
      bind =
        [
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
          ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05-"
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPause, exec, playerctl play-pause"
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPrev, exec, playerctl previous"
          ",XF86MonBrightnessDown, exec, brightnessctl s 5%-"
          ",XF86MonBrightnessUp, exec, brightnessctl s +5%"
          "$mod, return, exec, alacritty"
          "$mod, b, exec, vivaldi"
          "$mod shift, n, movewindow, l"
          "$mod shift, e, movewindow, d"
          "$mod shift, i, movewindow, u"
          "$mod shift, o, movewindow, r"
          "$mod, f, fullscreen, 1"
          "$mod, n, movefocus, l"
          "$mod, e, movefocus, d"
          "$mod, i, movefocus, u"
          "$mod, o, movefocus, r"
          "$mod, h, killactive,"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList
            (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
  };
}
