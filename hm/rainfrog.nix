{ ... }:

{
  xdg.configFile."rainfrog/rainfrog_config.toml".text = ''
    [settings]
    mouse_mode = true

    [keybindings.Menu]
    "q" = "Quit"
    "<Ctrl-c>" = "AbortQuery"
    "<Ctrl-m>" = "FocusMenu"
    "<Ctrl-e>" = "FocusEditor"
    "<Ctrl-r>" = "FocusData"
    "<Ctrl-h>" = "FocusHistory"
    "<Tab>" = "CycleFocusForwards"
    "<Backtab>" = "CycleFocusBackwards"

    [keybindings.Editor]
    "q" = "Quit"
    "<Ctrl-c>" = "AbortQuery"
    "<Ctrl-m>" = "FocusMenu"
    "<Ctrl-e>" = "FocusEditor"
    "<Ctrl-r>" = "FocusData"
    "<Ctrl-h>" = "FocusHistory"
    "<Ctrl-t>" = "FocusFavorites"
    "<Tab>" = "CycleFocusForwards"
    "<Backtab>" = "CycleFocusBackwards"
    "<Ctrl-s>" = "SubmitEditorQuery"

    [keybindings.History]
    "q" = "Quit"
    "<Ctrl-c>" = "AbortQuery"
    "<Ctrl-m>" = "FocusMenu"
    "<Ctrl-e>" = "FocusEditor"
    "<Ctrl-r>" = "FocusData"
    "<Ctrl-h>" = "FocusHistory"
    "<Ctrl-t>" = "FocusFavorites"
    "<Tab>" = "CycleFocusForwards"
    "<Backtab>" = "CycleFocusBackwards"

    [keybindings.Data]
    "q" = "Quit"
    "<Ctrl-c>" = "AbortQuery"
    "<Ctrl-m>" = "FocusMenu"
    "<Ctrl-e>" = "FocusEditor"
    "<Ctrl-r>" = "FocusData"
    "<Ctrl-h>" = "FocusHistory"
    "<Ctrl-t>" = "FocusFavorites"
    "<Tab>" = "CycleFocusForwards"
    "<Backtab>" = "CycleFocusBackwards"

    [keybindings.Favorites]
    "q" = "Quit"
    "<Ctrl-c>" = "AbortQuery"
    "<Ctrl-m>" = "FocusMenu"
    "<Ctrl-e>" = "FocusEditor"
    "<Ctrl-r>" = "FocusData"
    "<Ctrl-h>" = "FocusHistory"
    "<Ctrl-t>" = "FocusFavorites"
    "<Tab>" = "CycleFocusForwards"
    "<Backtab>" = "CycleFocusBackwards"


    [keybindings.PopUp]
    "<Ctrl-c>" = "Quit"

    [db]
    kyogre-test = { connection_string = "postgresql://postgres:test123@127.0.0.1:5534/test", driver = "postgres" }
    kyogre-local = { connection_string = "postgresql://postgres:test123@127.0.0.1:5532", driver = "postgres" }
    gengar-local = { host = "localhost", driver = "postgres", port = 5432, database = "postgres", username = "postgres" }
    gengar-migration = { connection_string = "postgresql://postgres:test123@127.0.0.1:5432", driver = "postgres" }
  '';

}
