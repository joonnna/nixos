local actions = require 'lir.actions'

require 'lir'.setup {
    show_hidden_files = false,
    ignore = {},
    devicons = {
        enable = false,
        highlight_dirname = true
    },
    mappings = {
        ['<CR>']  = actions.edit,
        ['u']     = actions.up,
        ['<ESC>'] = actions.quit,
        ['T']     = actions.mkdir,
        ['N']     = actions.newfile,
        ['R']     = actions.rename,
        ['.']     = actions.toggle_show_hidden,
        ['D']     = actions.delete,
    },
    float = {
        winblend = 0,
        curdir_window = {
            enable = true,
            highlight_dirname = true
        },
    },
    hide_cursor = true
}
