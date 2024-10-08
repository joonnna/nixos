function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end

    bind yy fish_clipboard_copy
    bind Y fish_clipboard_copy
    bind p fish_clipboard_paste
end


function ex
    if test -f "$argv[1]"
        switch "$argv[1]"
            case '*.tar.bz2'
                tar xjf "$argv[1]"
            case '*.tar.gz'
                tar xzf "$argv[1]"
            case '*.bz2'
                bunzip2 "$argv[1]"
            case '*.rar'
                unrar x "$argv[1]"
            case '*.gz'
                gunzip "$argv[1]"
            case '*.tar'
                tar xf "$argv[1]"
            case '*.tbz2'
                tar xjf "$argv[1]"
            case '*.tgz'
                tar xzf "$argv[1]"
            case '*.zip'
                unzip "$argv[1]"
            case '*.Z'
                uncompress "$argv[1]"
            case '*.7z'
                7z x "$argv[1]"
            case '*'
                echo "'$argv[1]' cannot be extracted via ex()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end


set -U fish_greeting ""
set -gx CARGO_HOME $HOME/.config/cargo
set -x OP_BIOMETRIC_UNLOCK_ENABLED true
set -x CLOUDSMITH_API_KEY "op://Employee/cloudsmith-api-token/token"
source /home/jon/.config/op/plugins.sh
fish_vi_key_bindings

set fish_cursor_insert line
