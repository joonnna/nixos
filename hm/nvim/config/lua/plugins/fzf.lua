require('fzf-lua').setup({
    fzf_colors = true,
    keymap = {
        builtin = {
            ['<C-d>'] = 'preview-page-down',
            ['<C-u>'] = 'preview-page-up',
        },
        fzf = {
            ['ctrl-a'] = 'select-all+accept',
            ['ctrl-e'] = 'down',
            ['ctrl-i'] = 'up',
            ['ctrl-o'] = 'select',
        }
    },
})

require("dbtui").setup({
    keymap = "<leader>db",      -- toggle
    open_keymap = "<leader>dD", -- open only
})
