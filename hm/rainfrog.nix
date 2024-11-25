{ ... }:

{
  xdg.configFile."rainfrog/rainfrog_config.toml".text = ''
    [settings]
    mouse_mode = true

    [keybindings.Menu]
    "<Ctrl-H>" = "Quit"
    "<Ctrl-c>" = "AbortQuery"
    # "<Ctrl-t>" = "FocusMenu"
    # "<Ctrl-s>" = "FocusEditor"
    # "<Ctrl-r>" = "FocusData"
    # "<Ctrl-a>" = "FocusHistory"
    "<Ctrl-n>" = "CycleFocusForwards"
    "<Ctrl-t>" = "CycleFocusBackwards"

    [keybindings.Editor]
    "<Ctrl-c>" = "AbortQuery"
    "<Ctrl-s>" = "SubmitEditorQuery"
    # "<Ctrl-m>" = "FocusMenu"
    # "<Ctrl-s>" = "FocusEditor"
    # "<Ctrl-r>" = "FocusData"
    # "<Ctrl-a>" = "FocusHistory"
    # "<Backtab>" = "CycleFocusBackwards"

    "<Ctrl-n>" = "CycleFocusForwards"
    "<Ctrl-t>" = "CycleFocusBackwards"

    [keybindings.History]
    "<Ctrl-H>" = "Quit"
    "<Ctrl-c>" = "AbortQuery"
    # "<Ctrl-t>" = "FocusMenu"
    # "<Ctrl-s>" = "FocusEditor"
    # "<Ctrl-r>" = "FocusData"
    # "<Ctrl-a>" = "FocusHistory"
    # "<Tab>" = "CycleFocusForwards"
    # "<Backtab>" = "CycleFocusBackwards"
    "<Ctrl-n>" = "CycleFocusForwards"
    "<Ctrl-t>" = "CycleFocusBackwards"

    [keybindings.Data]
    "<Ctrl-H>" = "Quit"
    "<Ctrl-c>" = "AbortQuery"
    # "<Ctrl-t>" = "FocusMenu"
    # "<Ctrl-s>" = "FocusEditor"
    # "<Ctrl-r>" = "FocusData"
    # "<Ctrl-a>" = "FocusHistory"

    # "<Tab>" = "CycleFocusForwards"
    # "<Backtab>" = "CycleFocusBackwards"
    #
    "<Ctrl-n>" = "CycleFocusForwards"
    "<Ctrl-t>" = "CycleFocusBackwards"

    [keybindings.PopUp]
    "<Ctrl-c>" = "Quit"
  '';

}
