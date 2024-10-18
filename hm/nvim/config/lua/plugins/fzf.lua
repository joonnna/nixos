require('fzf-lua').setup({
    fzf_colors = true,
    keymap = {
        builtin = {
            ['<C-d>'] = 'preview-page-down',
            ['<C-u>'] = 'preview-page-up',
        },
        fzf = {
            ['ctrl-o'] = 'select-all+accept',
            ['ctrl-n'] = 'down',
            ['ctrl-e'] = 'up',
        }
    },
})
