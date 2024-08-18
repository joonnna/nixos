function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end

    bind yy fish_clipboard_copy
    bind Y fish_clipboard_copy
    bind p fish_clipboard_paste
end

set -U fish_greeting ""
set -gx CARGO_HOME $HOME/.config/cargo
set -x OP_BIOMETRIC_UNLOCK_ENABLED true
source /home/jon/.config/op/plugins.sh
fish_vi_key_bindings
