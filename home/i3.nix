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
        };
    };
  };
}
