function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cn forward-char
    end
    bind yy fish_clipboard_copy
    bind Y fish_clipboard_copy
    bind P fish_clipboard_paste
    bind \cs -M insert fzf-cd-widget
end


set -U fish_greeting ""
set -U fish_color_command cyan
set -U fish_color_param yellow
set -U fish_color_autosuggestion 555
set -gx CARGO_HOME $HOME/.config/cargo
set -x OP_BIOMETRIC_UNLOCK_ENABLED true
set -x CLOUDSMITH_API_KEY "op://Employee/cloudsmith-api-token/token"
source /home/jon/.config/op/plugins.sh

fish_vi_key_bindings
fzf --fish | source

set fish_cursor_insert line
