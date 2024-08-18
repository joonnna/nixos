{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    # https://1password.community/discussion/141663/i-cant-start-wayland-native-version-of-1password
    # xwayland = {
    #   enable = false;
    # };
    settings = {
      env = [
        "BROWSER,vivaldi"
        "XDG_SESSION_TYPE,wayland"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        # need for dbeaver scaling issue (https://github.com/dbeaver/dbeaver/issues/6581)
        "GDK_BACKEND,x11"
      ];

      "$mod" = "ALT";
      "general:no_border_on_floating" = true;

      "general:col.active_border" = "0x00bfff";
      # "general:col.active_border" = "0x80f2d2";
      "general:gaps_out" = 5;
      "general:gaps_in" = 5;
      "dwindle:no_gaps_when_only" = 1;


      "cursor:no_hardware_cursors" = true;
      # "cursor:allow_dumb_copy" = true;
      "decoration:rounding" = 20;
      "decoration:active_opacity" = 0.95;
      "decoration:inactive_opacity" = 0.88;
      "decoration:blur:enabled" = true;
      "decoration:blur:size" = 10;
      "decoration:blur:passes" = 3;
      "decoration:blur:new_optimizations" = true;

      exec-once = [ "${pkgs.hyprpaper}/bin/hyprpaper" ];

      # source: https://github.com/FlafyDev/nixos-config/blob/main/modules/display/hyprland/default.nix
      windowrulev2 =
        let
          rulesForWindow = window: map (rule: "${rule},${window}");
        in
        [ ]
        # Specific window rules
        ++ (rulesForWindow "title:(1Password)" [ "float" "size 70% 70%" "center" ])
        # General window rules
        ++ (rulesForWindow "floating:0" [ "rounding 0" ])
        ++ (rulesForWindow "floating:1" [ "rounding 5" ])
        ++ (rulesForWindow "floating:0" [ "noshadow" ]);

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
          "$mod, p, exec, 1password"
          "$mod, l, exec, vivaldi"
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
          "$mod, d, exec, bemenu-run"
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
