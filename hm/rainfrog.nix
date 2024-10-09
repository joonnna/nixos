{ ... }:

{
  xdg.configFile."rainfrog/rainfrog_config.toml".text = ''
    [settings]
    mouse_mode = true

    [keybindings.Menu]
    "<Ctrl-c>" = "Quit"
    "q" = "AbortQuery"
    "<Ctrl-n>" = "FocusMenu"
    "<Ctrl-s>" = "FocusEditor"
    "<Ctrl-t>" = "FocusData"
    "<Ctrl-h>" = "FocusHistory"
    "<Tab>" = "CycleFocusForwards"
    "<Backtab>" = "CycleFocusBackwards"

    [keybindings.Editor]
    "<Alt-q>" = "AbortQuery"
    "<Ctrl-Enter>" = "SubmitEditorQuery"
    "<Ctrl-n>" = "FocusMenu"
    "<Ctrl-s>" = "FocusEditor"
    "<Ctrl-t>" = "FocusData"
    "<Ctrl-h>" = "FocusHistory"
    "<Backtab>" = "CycleFocusBackwards"

    [keybindings.History]
    "<Ctrl-c>" = "Quit"
    "q" = "AbortQuery"
    "<Ctrl-n>" = "FocusMenu"
    "<Ctrl-s>" = "FocusEditor"
    "<Ctrl-t>" = "FocusData"
    "<Ctrl-h>" = "FocusHistory"
    "<Tab>" = "CycleFocusForwards"
    "<Backtab>" = "CycleFocusBackwards"

    [keybindings.Data]
    "<Ctrl-c>" = "Quit"
    "q" = "AbortQuery"
    "<Ctrl-n>" = "FocusMenu"
    "<Ctrl-s>" = "FocusEditor"
    "<Ctrl-t>" = "FocusData"
    "<Ctrl-h>" = "FocusHistory"

    "<Tab>" = "CycleFocusForwards"
    "<Backtab>" = "CycleFocusBackwards"

    [keybindings.PopUp]
    "<Ctrl-c>" = "Quit"
  '';

}
